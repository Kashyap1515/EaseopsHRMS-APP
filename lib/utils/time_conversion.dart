import 'package:easeops_hrms/data/auth_service/auth_service.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

String formatDateTimeInLocalTimeZone(DateTime dateTime) {
  final utcDateTime = dateTime.toString().split('').last == 'Z'
      ? dateTime
      : DateTime.parse('${dateTime.toIso8601String()}Z');
  final userTimeZone = tz.getLocation(AuthService.userLocalTimeZone);
  // final userTimeZone = tz.getLocation('Asia/Kolkata');
  final localDateTime = tz.TZDateTime.from(utcDateTime, userTimeZone);
  final formattedTime = DateFormat.jm().format(localDateTime);
  return formattedTime;
}

DateTime convertDateTimeLocalTimeZone(DateTime dateTime) {
  final utcDateTime = dateTime.toString().split('').last == 'Z'
      ? dateTime
      : DateTime.parse('${dateTime.toIso8601String()}Z');
  final userTimeZone = tz.getLocation(AuthService.userLocalTimeZone);
  final localDateTime = tz.TZDateTime.from(utcDateTime, userTimeZone);
  return localDateTime;
}


String formatDateToYDashMMDashD(DateTime? date) {
  if (date == null) {
    return '-';
  } else {
    return DateFormat("yyyy-MM-dd").format(date);
  }
}
DateTime convertToTimeZone(DateTime dateTime) {
  final userTimeZone = tz.getLocation(AuthService.userLocalTimeZone);
  final localDateTime = tz.TZDateTime.from(dateTime, userTimeZone);
  return localDateTime;
}

Future<void> getLocalTimezone() async {
  AuthService.userLocalTimeZone =
      await FlutterTimezone.getLocalTimezone() == 'Asia/Calcutta'
          ? 'Asia/Kolkata'
          : await FlutterTimezone.getLocalTimezone();
}
