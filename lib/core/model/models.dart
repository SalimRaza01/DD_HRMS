class ShiftTimeModel {
  final String startTime;
  final String endTime;

  ShiftTimeModel({required this.startTime, required this.endTime});

  factory ShiftTimeModel.fromJson(Map<String, dynamic> json) {
    return ShiftTimeModel(
      startTime: json['startAt'],
      endTime: json['endAt'],
    );
  }
}

class LeaveBalance {
  final String casualLeave;
  final String medicalLeave;
  final String earnedLeave;
  final String paternityLeave;
  final String maternityLeave;
  final String compOffLeave;

  LeaveBalance({
    required this.casualLeave,
    required this.medicalLeave,
    required this.earnedLeave,
    required this.paternityLeave,
    required this.maternityLeave,
    required this.compOffLeave,
  });

  factory LeaveBalance.fromJson(Map<String, dynamic> json) {
    return LeaveBalance(
      casualLeave: json['casualLeave'],
      medicalLeave: json['medicalLeave'],
      earnedLeave: json['earnedLeave'],
      paternityLeave: json['paternityLeave'],
      maternityLeave: json['maternityLeave'],
      compOffLeave: json['compOffLeave'],
    );
  }
}

class Attendance {
  final String employeeName;
  final String employeeCode;
  final String gender;
  final String employmentType;
  final String attendanceDate;
  final String inTime;
  final String outTime;
  final String status;
  final int duration;
  final String punchRecords;
  final int lateby;
  final int earlyBy;
  final int weekOff;

  Attendance({
    required this.employeeName,
    required this.employeeCode,
    required this.gender,
    required this.employmentType,
    required this.attendanceDate,
    required this.inTime,
    required this.outTime,
    required this.status,
    required this.duration,
    required this.punchRecords,
    required this.lateby,
    required this.earlyBy,
    required this.weekOff,
  });


  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      employeeName: json['EmployeeName'] ?? '',
      employeeCode: json['EmployeeCode'] ?? '',
      gender: json['Gender'] ?? '',
      employmentType: json['EmployementType'] ?? '',
      attendanceDate: json['AttendanceDate'] ?? '',
      inTime: json['InTime'] ?? '',
      outTime: json['OutTime'] ?? '',
      status: json['Status'] ?? '',
      duration: json['Duration'] ?? 0,
      punchRecords: json['PunchRecords'] ?? '',
      lateby: json['LateBy'] ?? 0,
      earlyBy: json['EarlyBy'] ?? 0,
      weekOff: json['WeeklyOff'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'EmployeeName': employeeName,
      'EmployeeCode': employeeCode,
      'Gender': gender,
      'EmployementType': employmentType,
      'AttendanceDate': attendanceDate,
      'InTime': inTime,
      'OutTime': outTime,
      'Status': status,
      'Duration': duration,
      'PunchRecords': punchRecords,
            'LateBy': lateby,
      'EarlyBy': earlyBy,
      'WeeklyOff': weekOff,
    };
  }
}

class LeaveHistory {
  final String id;
  final String leaveType;
  final String leaveStartDate;
  final String leaveEndDate;
  final String totalDays;
  final String reason;
  final String status;
  final String approvedBy;
  final String dateTime;

  LeaveHistory({
    required this.id,
    required this.leaveType,
    required this.leaveStartDate,
    required this.leaveEndDate,
    required this.totalDays,
    required this.reason,
    required this.status,
    required this.approvedBy,
    required this.dateTime,
  });

  factory LeaveHistory.fromJson(Map<String, dynamic> json) {
    return LeaveHistory(
      id: json['_id'] ?? '',
      leaveType: json['leaveType'] ?? '',
      leaveStartDate: json['leaveStartDate'] ?? '',
      leaveEndDate: json['leaveEndDate'] ?? '',
      totalDays: json['totalDays'] ?? '',
      reason: json['reason'] ?? '',
      status: json['status'] ?? '',
      approvedBy: json['approvedBy'] ?? '',
      dateTime: json['dateTime'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leaveType': leaveType,
      'leaveStartDate': leaveStartDate,
      'leaveEndDate': leaveEndDate,
      'totalDays': totalDays,
      'reason': reason,
      'status': status,
      'approvedBy': approvedBy,
      'dateTime': dateTime,
    };
  }
}

class EmployeeProfile {
  final String employeeId;
  final String employeeName;
  final String employeeCode;
  final String gender;
  final String departmentId;
  final String designation;
  final String doj;
  final String employeeCodeInDevice;
  final String employmentType;
  final String employeeStatus;
  final String accountStatus;
  final String fatherName;
  final String motherName;
  final String residentialAddress;
  final String permanentAddress;
  final String contactNo;
  final String email;
  final String dob;
  final String placeOfBirth;
  final String bloodGroup;
  final String workPlace;
  final String maritalStatus;
  final String nationality;
  final String overallExperience;
  final String qualifications;
  final String emergencyContact;
  final String managerId;
  final String teamLeadId;
  final String employeePhoto;

  EmployeeProfile({
    required this.employeeId,
    required this.employeeName,
    required this.employeeCode,
    required this.gender,
    required this.departmentId,
    required this.designation,
    required this.doj,
    required this.employeeCodeInDevice,
    required this.employmentType,
    required this.employeeStatus,
    required this.accountStatus,
    required this.fatherName,
    required this.motherName,
    required this.residentialAddress,
    required this.permanentAddress,
    required this.contactNo,
    required this.email,
    required this.dob,
    required this.placeOfBirth,
    required this.bloodGroup,
    required this.workPlace,
    required this.maritalStatus,
    required this.nationality,
    required this.overallExperience,
    required this.qualifications,
    required this.emergencyContact,
    required this.managerId,
    required this.teamLeadId,
    required this.employeePhoto,
  });

  factory EmployeeProfile.fromJson(Map<String, dynamic> json) {
    return EmployeeProfile(
      employeeId: json['employeeId'].toString(),
      employeeName: json['employeeName'],
      employeeCode: json['employeeCode'],
      gender: json['gender'],
      departmentId: json['departmentId'].toString(),
      designation: json['designation'],
      doj: json['doj'],
      employeeCodeInDevice: json['employeeCodeInDevice'],
      employmentType: json['employmentType'],
      employeeStatus: json['employeeStatus'],
      accountStatus: json['accountStatus'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      residentialAddress: json['residentialAddress'],
      permanentAddress: json['permanentAddress'],
      contactNo: json['contactNo'],
      email: json['email'],
      dob: json['dob'],
      placeOfBirth: json['placeOfBirth'],
      bloodGroup: json['bloodGroup'],
      workPlace: json['workPlace'],
      maritalStatus: json['maritalStatus'],
      nationality: json['nationality'],
      overallExperience: json['overallExperience'],
      qualifications: json['qualifications'],
      emergencyContact: json['emergencyContact'],
      managerId: json['managerId'],
      teamLeadId: json['teamLeadId'],
      employeePhoto: json['employeePhoto'],
    );
  }
}
