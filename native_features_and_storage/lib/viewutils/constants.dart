import 'package:dio/dio.dart';

class ConstantsUtil {
  static Options jsonOptions() {
    return Options(
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }

  static String dataBaseName = 'stored_places';
}
