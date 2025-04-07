import 'package:easeops_hrms/app_export.dart';

class Logger {
  static LogMode _logMode = LogMode.debug;

  void init(LogMode mode) {
    Logger._logMode = mode;
  }

  // Write a log entry
  static void log(dynamic data, {StackTrace? stackTrace}) {
    if (_logMode == LogMode.debug || _logMode == LogMode.live) {
      if (kDebugMode) {
        print(data);
        if (stackTrace != null) {
          print(stackTrace);
        }
      }
    }
  }
}

enum LogMode { debug, live }
