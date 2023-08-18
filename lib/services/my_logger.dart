import 'package:f_logs/f_logs.dart';

class MyLogger {
  MyLogger() {
    LogsConfig config = FLog.getDefaultConfigurations()
      ..activeLogLevel = LogLevel.DEBUG
      ..isLogsEnabled = true
      ..isDevelopmentDebuggingEnabled = true
      ..timestampFormat = TimestampFormat.TIME_FORMAT_FULL_3
      ..formatType = FormatType.FORMAT_CUSTOM
      ..fieldOrderFormatCustom = [
        FieldName.TIMESTAMP,
        FieldName.LOG_LEVEL,
        FieldName.CLASSNAME,
        FieldName.METHOD_NAME,
        FieldName.TEXT,
      ]
      ..customOpeningDivider = "("
      ..customClosingDivider = ")";

    FLog.applyConfigurations(config);
  }
}
