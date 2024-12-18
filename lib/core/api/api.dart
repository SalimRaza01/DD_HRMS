import 'package:database_app/core/api/api_config.dart';
import 'package:database_app/core/model/models.dart';
import 'package:database_app/presentation/screens/home/bottom_navigation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

final Box _authBox = Hive.box('authBox');
final Dio dio = Dio();

Future<List<Attendance>> fetchAttendence() async {
  String empID = _authBox.get('employeeId');
  final dateTo = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final dateFrom = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(Duration(days: 365)));

  print('fromDate $dateFrom toDate $dateTo');
  try {
    final response = await dio.get('$getAttendenceData/$empID',
        queryParameters: {"dateFrom": dateFrom, "dateTo": dateTo, "page": 1});

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      return data.map((item) => Attendance.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load attendance data');
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}

Future<LeaveBalance> fetchLeaves() async {
  String empID = _authBox.get('employeeId');
  try {
    final response = await dio.get('$getEmployeeData/$empID');

    if (response.statusCode == 200) {
      return LeaveBalance.fromJson(response.data['data']['leaveBalance']);
    } else {
      throw Exception('Failed to load leave data');
    }
  } catch (e) {
    throw Exception('Failed to load leave data: $e');
  }
}

Future<ShiftTimeModel> fetchShiftTime() async {
  String empID = _authBox.get('employeeId');
  try {
    final response = await dio.get('$getEmployeeData/$empID');

    if (response.statusCode == 200) {
      String mgrId = response.data['data']['managerId'];
      await _authBox.put('managerId', mgrId);
      return ShiftTimeModel.fromJson(response.data['data']['shiftTime']);
    } else {
      throw Exception('Failed to load shift time data');
    }
  } catch (e) {
    throw Exception('Failed to load shift time data: $e');
  }
}

class AuthProvider with ChangeNotifier {
  Future<void> login(String emailController, String passController,
      BuildContext context) async {
    try {
      final response = await dio.post(employeeLogin, data: {
        "email": emailController,
        "password": passController,
      });

      if (response.statusCode == 200) {
        final responseData = response.data;
        final token = responseData['token'];
        final employeeId = responseData['data']['employeeId'];
        final employeeName = responseData['data']['employeeName'];
        final employeeDesign = responseData['data']['designation'];
        final email = responseData['data']['email'];

        // Save the token in Hive
        await _authBox.put('token', token);
        await _authBox.put('employeeId', employeeId.toString());
        await _authBox.put('employeeName', employeeName);
        await _authBox.put('employeeDesign', employeeDesign);
        await _authBox.put('email', email);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BottomNavigation()));

        print('successfull');
      } else {
        print('failed ${response.statusMessage}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

Future<void> applyLeave(
  BuildContext context,
  String leaveType,
  String startDate,
  String endDate,
  String totalDays,
  String reason,
) async {
  String mgrId = _authBox.get('managerId');
  String empID = _authBox.get('employeeId');
  String token = _authBox.get('token');
  print('managerId $mgrId');

try {
  final response = await dio.post('$employeeApplyLeave/$empID',
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      }),
      data: {
        "leaveType": leaveType == 'Comp-off Leave'
            ? 'compOffLeave'
            : leaveType == 'Casual Leave'
                ? 'casualLeave'
                : leaveType == 'Medical Leave'
                    ? 'medicalLeave'
                    : leaveType == 'Earned Leave'
                        ? 'earnedLeave'
                        : null,
        "leaveStartDate": startDate,
        "leaveEndDate": endDate,
        "totalDays": totalDays,
        "reason": reason,
        "approvedBy": mgrId
      });
  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Leave request submitted successfully'),
        backgroundColor: Colors.green,
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: ${response}'),
        backgroundColor: Colors.red,
      ),
    );
  } 
} on DioException catch (e) {
  print('Dio Exception: ${e.message}');
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Request failed: ${e.message}'),
      backgroundColor: Colors.red,
    ),
  );
}
}

Future<List<LeaveHistory>> fetchLeaveHistory(String status) async {
  String empID = _authBox.get('employeeId');
  String token = _authBox.get('token');
  print('status $status');
  try {
    final response = await dio.get('$getLeaveHistory/$empID',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }));

    if (response.statusCode == 200) {
      List<dynamic> data = response.data['data']
          .where((leave) => leave['status'] == status)
          .toList();

      return data.map((leaveData) => LeaveHistory.fromJson(leaveData)).toList();
    } else {
      throw Exception('Failed to load leave history');
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}

Future<EmployeeProfile> fetchEmployeeDetails() async {
  String empID = _authBox.get('employeeId');
  Dio dio = Dio();
  try {
    final response = await dio.get('$getEmployeeData/$empID');

    return EmployeeProfile.fromJson(response.data['data']);
  } catch (e) {
    throw Exception('Failed to load employee profile');
  }
}


