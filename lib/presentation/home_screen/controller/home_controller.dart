import 'dart:developer';

import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/home_screen/model/attendance_report_user.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  Rx<Status> homeStatus = Status.loading.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final NetworkApiService _apiService = NetworkApiService();
  Rx<DateTime> startDateTime =
      DateTime(DateTime.now().year, DateTime.now().month - 1, 1).obs;
  Rx<DateTime> startThisMonthDateTime =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  Rx<DateTime> endDateTime =
      DateTime(DateTime.now().year, DateTime.now().month, 0).obs;
  RxString lastMonthName = DateFormat('MMMM')
      .format(DateTime(DateTime.now().year, DateTime.now().month - 1, 1))
      .obs;
  RxString currentMonthName = DateFormat('MMMM')
      .format(DateTime(DateTime.now().year, DateTime.now().month, 1))
      .obs;
  RxList<String> checkinTimes = <String>[].obs;
  RxList<String> checkoutTimes = <String>[].obs;

  RxString currUserId = ''.obs;
  RxString lastMonthPresentCount = ''.obs;
  RxString lastMonthAbsentCount = ''.obs;
  RxString lastMonthLateCount = ''.obs;
  RxInt lastMonthHolidaysCount = 0.obs;
  RxString thisMonthPresentCount = ''.obs;
  RxString thisMonthAbsentCount = ''.obs;
  RxString thisMonthLateCount = ''.obs;
  RxInt thisMonthHolidaysCount = 0.obs;
  RxString userLocalTimeZone = 'Asia/Kolkata'.obs;
  List<AttendanceReportUserModel> lastMonthUserData =
      <AttendanceReportUserModel>[];
  List<AttendanceReportUserModel> thisMonthData = <AttendanceReportUserModel>[];
  List<AttendanceReportUserModel> todayData = <AttendanceReportUserModel>[];

  Future<void> getTodayData() async {
    final locationId = GetStorageHelper.getCurrentLocationData() != null
        ? GetStorageHelper.getCurrentLocationData()!.locationId
        : '';
    homeStatus.value = Status.loading;
    currUserId.value = GetStorageHelper.getUserData().id ?? '';
    if (currUserId.value == '') {
      return;
    }
    await _apiService
        .getResponse(
      '${ApiEndPoints.apiAttendanceUserData}?utc_from_dt=${formatDateToYDashMMDashD(DateTime.now())} 00:00:00.000&utc_till_dt=${formatDateToYDashMMDashD(DateTime.now())} 23:59:59.000&user_id=${currUserId.value}&location_id_list=$locationId',
    )
        .then((value) async {
      if (value != null) {
        todayData.clear();
        for (var i = 0; i < value.length; i++) {
          todayData.add(AttendanceReportUserModel.fromJson(value[i]));
        }
        for (var attendances in todayData) {
          for (var attendance
              in attendances.attendanceList ?? <AttendanceList>[]) {
            for (var session in attendance.sessionList ?? <SessionList>[]) {
              if (session.checkinAt != null) {
                checkinTimes.add(formatDate(
                    convertDateTimeLocalTimeZone(session.checkinAt!)));
              } else {
                checkinTimes.add('-');
              }
              if (session.checkoutAt != null) {
                checkoutTimes.add(formatDate(
                    convertDateTimeLocalTimeZone(session.checkoutAt!)));
              } else {
                checkoutTimes.add('-');
              }
            }
          }
        }
      } else {
        homeStatus.value = Status.completed;
      }
      homeStatus.value = Status.completed;
    });
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  Future<void> getThisMonthData() async {
    final locationId = GetStorageHelper.getCurrentLocationData() != null
        ? GetStorageHelper.getCurrentLocationData()!.locationId
        : '';
    homeStatus.value = Status.loading;
    currUserId.value = GetStorageHelper.getUserData().id ?? '';
    if (currUserId.value == '') {
      return;
    }
    await _apiService
        .getResponse(
      '${ApiEndPoints.apiAttendanceUserData}?utc_from_dt=${formatDateToYDashMMDashD(startThisMonthDateTime.value)} 00:00:00.000&utc_till_dt=${formatDateToYDashMMDashD(DateTime.now())} 23:59:59.000&user_id=${currUserId.value}&location_id_list=$locationId',
    )
        .then((value) async {
      if (value != null) {
        thisMonthData.clear();
        for (var i = 0; i < value.length; i++) {
          thisMonthData.add(AttendanceReportUserModel.fromJson(value[i]));
        }
        for (var report in thisMonthData) {
          thisMonthPresentCount.value = report.getPresentHours();
          thisMonthAbsentCount.value = report.getAbsentHours(
            now: startThisMonthDateTime.value,
            totalDaysInMonth: DateTime.now().day,
          );
          thisMonthLateCount.value = report.getLateHours();
          thisMonthHolidaysCount.value = report.getHolidays(
            now: startThisMonthDateTime.value,
          );
        }
      } else {
        homeStatus.value = Status.completed;
      }
      homeStatus.value = Status.completed;
    });
  }

  Future<void> getLastMonthData() async {
    final locationId = GetStorageHelper.getCurrentLocationData() != null
        ? GetStorageHelper.getCurrentLocationData()!.locationId
        : '';
    homeStatus.value = Status.loading;
    currUserId.value = GetStorageHelper.getUserData().id ?? '';
    if (currUserId.value == '') {
      return;
    }
    await _apiService
        .getResponse(
      '${ApiEndPoints.apiAttendanceUserData}?utc_from_dt=${formatDateToYDashMMDashD(startDateTime.value)} 00:00:00.000&utc_till_dt=${formatDateToYDashMMDashD(endDateTime.value)} 23:59:59.000&user_id=${currUserId.value}&location_id_list=$locationId',
    )
        .then((value) async {
      if (value != null) {
        lastMonthUserData.clear();
        for (var i = 0; i < value.length; i++) {
          lastMonthUserData.add(AttendanceReportUserModel.fromJson(value[i]));
        }
        for (var report in lastMonthUserData) {
          lastMonthPresentCount.value = report.getPresentHours();
          lastMonthAbsentCount.value = report.getAbsentHours(
            now: startDateTime.value,
            totalDaysInMonth: report.getDaysInMonth(
              startDateTime.value.year,
              startDateTime.value.month,
            ),
          );
          lastMonthLateCount.value = report.getLateHours();
          lastMonthHolidaysCount.value = report.getHolidays(
            now: startDateTime.value,
          );
        }
        homeStatus.value = Status.completed;
      } else {
        homeStatus.value = Status.completed;
      }
      homeStatus.value = Status.completed;
    });
  }

  DateTime convertDateTimeLocalTimeZone(DateTime dateTime) {
    try {
      final utcDateTime = dateTime.toString().split('').last == 'Z'
          ? dateTime
          : DateTime.parse('${dateTime.toIso8601String().split('.').first}Z');

      final userTimeZone = tz.getLocation(userLocalTimeZone.value);
      final localDateTime = tz.TZDateTime.from(utcDateTime, userTimeZone);
      return localDateTime;
    } catch (e) {
      return dateTime;
    }
  }

  Future<void> getLocalTimezone() async {
    userLocalTimeZone.value =
        await FlutterTimezone.getLocalTimezone() == 'Asia/Calcutta'
            ? 'Asia/Kolkata'
            : await FlutterTimezone.getLocalTimezone();
  }

  int convertTimeToWorkingDays(String timeStr) {
    RegExp regExp = RegExp(r'(\d+)\s*(?:hours?|h)');
    Match? match = regExp.firstMatch(timeStr);

    if (match != null) {
      try {
        int hours = int.parse(match.group(1)!);
        double days = hours / 8;
        return days.floor();
      } catch (e) {
        log('Invalid Time Format');
        return 0;
      }
    } else {
      log('Invalid Time Format');
      return 0;
    }
  }
}
