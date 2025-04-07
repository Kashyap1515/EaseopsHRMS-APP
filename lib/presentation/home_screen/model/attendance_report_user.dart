import 'dart:convert';
import 'dart:developer';

import 'package:easeops_hrms/app_export.dart';

List<AttendanceReportUserModel> attendanceReportUserModelFromJson(String str) =>
    List<AttendanceReportUserModel>.from(
        json.decode(str).map((x) => AttendanceReportUserModel.fromJson(x)));

String attendanceReportUserModelToJson(List<AttendanceReportUserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendanceReportUserModel {
  User? user;
  List<AttendanceList>? attendanceList;

  AttendanceReportUserModel({
    this.user,
    this.attendanceList,
  });

  factory AttendanceReportUserModel.fromJson(Map<String, dynamic> json) =>
      AttendanceReportUserModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        attendanceList: json["attendance_list"] == null
            ? []
            : List<AttendanceList>.from(json["attendance_list"]!
                .map((x) => AttendanceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "attendance_list": attendanceList == null
            ? []
            : List<dynamic>.from(attendanceList!.map((x) => x.toJson())),
      };

  String getPresentHours() {
    if (attendanceList == null) return "0 mins";

    int totalMinutes = attendanceList!
        .fold(0, (sum, item) => sum + (item.totalTimeSpentInMinutes ?? 0));
    return formatTime(totalMinutes);
  }

  String getAbsentHours({
    required DateTime now,
    required int totalDaysInMonth,
  }) {
    if (attendanceList == null) return "0 mins";
    int totalWorkingDays = getTotalWorkingDays(
      now: now,
      totalDaysInMonth: totalDaysInMonth,
    );
    int presentDays = attendanceList?.length ?? 0;
    int absentMinutes = (totalWorkingDays - presentDays) * 8 * 60;

    return formatTime(absentMinutes);
  }

  int getTotalWorkingDays({
    required DateTime now,
    required int totalDaysInMonth,
  }) {
    int workingDays = 0;

    for (int day = 1; day <= totalDaysInMonth; day++) {
      DateTime currentDate = DateTime(now.year, now.month, day);
      if (currentDate.weekday >= DateTime.monday &&
          currentDate.weekday <= DateTime.friday) {
        workingDays++;
      }
    }

    return workingDays;
  }

  int getDaysInMonth(int year, int month) {
    DateTime firstDayNextMonth = DateTime(year, month + 1, 1);
    DateTime lastDayCurrentMonth =
        firstDayNextMonth.subtract(const Duration(days: 1));
    return lastDayCurrentMonth.day;
  }

  String getLateHours() {
    num totalLateMinutes = 0;
    if (attendanceList != null) {
      for (var attendance in attendanceList!) {
        for (var session in attendance.sessionList ?? <SessionList>[]) {
          if (session.checkinAt != null && session.shift != null) {
            try {
              DateTime shiftStartUtc =
                  _parseShiftTime(session.shift!.startTime!).toUtc();
              String formattedShiftTime =
                  "${shiftStartUtc.hour.toString().padLeft(2, '0')}:${shiftStartUtc.minute.toString().padLeft(2, '0')}:${shiftStartUtc.second.toString().padLeft(2, '0')}";
              DateTime shiftStart = _parseShiftTime(formattedShiftTime);
              String formattedTime =
                  "${session.checkinAt!.hour.toString().padLeft(2, '0')}:${session.checkinAt!.minute.toString().padLeft(2, '0')}:${session.checkinAt!.second.toString().padLeft(2, '0')}";
              DateTime checkinAt = _parseShiftTime(formattedTime);

              if (checkinAt.isAfter(shiftStart)) {
                totalLateMinutes +=
                    checkinAt.difference(shiftStart).inMinutes.abs();
              }
            } catch (e) {
              log('Error Getting Late Hours $e');
            }
          }
        }
      }
    }

    if (totalLateMinutes == 0) {
      return "0 hours";
    }
    int lateHours = totalLateMinutes ~/ 60;
    num lateMinutes = totalLateMinutes % 60;

    if (lateHours > 0) {
      return "${lateHours}h ${lateMinutes}m";
    } else if (lateMinutes > 0) {
      return "$lateMinutes minutes";
    } else {
      return "0 hours";
    }
  }

  String formatTime(int totalMinutes) {
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    if (hours == 0 && minutes > 0) {
      return "$minutes mins";
    }

    if (hours > 0 && minutes > 0) {
      return "${hours}h ${minutes}m";
    }
    if (hours > 0 && minutes == 0) {
      return "$hours hours";
    }
    return "$minutes mins";
  }

  int getHolidays({required DateTime now}) {
    int count = 0;
    int totalDaysInMonth = getDaysInMonth(now.year, now.month);
    for (int day = 1; day <= totalDaysInMonth; day++) {
      DateTime date = DateTime(DateTime.now().year, 2, day);
      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) {
        count++;
      }
    }
    return count;
  }

  DateTime _parseShiftTime(String shiftTime) {
    List<String> timeParts = shiftTime.split(":");
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
  }
}

class AttendanceList {
  String? id;
  DateTime? markedAt;
  Location? location;
  int? totalTimeSpentInMinutes;
  List<SessionList>? sessionList;

  AttendanceList({
    this.id,
    this.markedAt,
    this.location,
    this.totalTimeSpentInMinutes,
    this.sessionList,
  });

  factory AttendanceList.fromJson(Map<String, dynamic> json) => AttendanceList(
        id: json["id"],
        markedAt: json["marked_at"] == null
            ? null
            : DateTime.parse(json["marked_at"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        totalTimeSpentInMinutes: json["total_time_spent_in_minutes"],
        sessionList: json["session_list"] == null
            ? []
            : List<SessionList>.from(
                json["session_list"]!.map((x) => SessionList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "marked_at": markedAt?.toIso8601String(),
        "location": location?.toJson(),
        "total_time_spent_in_minutes": totalTimeSpentInMinutes,
        "session_list": sessionList == null
            ? []
            : List<dynamic>.from(sessionList!.map((x) => x.toJson())),
      };
}

class Location {
  String? id;
  String? alias;
  String? location;

  Location({
    this.id,
    this.alias,
    this.location,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        alias: json["alias"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "location": location,
      };
}

class SessionList {
  String? id;
  DateTime? checkinAt;
  DateTime? checkoutAt;
  Shift? shift;

  SessionList({
    this.id,
    this.checkinAt,
    this.checkoutAt,
    this.shift,
  });

  factory SessionList.fromJson(Map<String, dynamic> json) => SessionList(
        id: json["id"],
        checkinAt: json["checkin_at"] == null
            ? null
            : DateTime.parse(json["checkin_at"]),
        checkoutAt: json["checkout_at"] == null
            ? null
            : DateTime.parse(json["checkout_at"]),
        shift: json["shift"] == null ? null : Shift.fromJson(json["shift"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "checkin_at": checkinAt?.toIso8601String(),
        "checkout_at": checkoutAt?.toIso8601String(),
        "shift": shift?.toJson(),
      };
}

class Shift {
  String? id;
  String? name;
  String? startTime;
  String? endTime;

  Shift({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["id"],
        name: json["name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start_time": startTime,
        "end_time": endTime,
      };
}

class User {
  String? id;
  String? name;
  String? displayPicture;

  User({
    this.id,
    this.name,
    this.displayPicture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        displayPicture: json["display_picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "display_picture": displayPicture,
      };
}
