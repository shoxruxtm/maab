import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/models.dart';

class ProductService {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> createReport(
      {required ReportModel newReport}) async {
    log(newReport.toString());
    await _preferences?.setString(
      "reports",
      jsonEncode(newReport.toJson()),
    );
  }

  static String? getReport() {
    log("${_preferences?.getString("reports")}");
    return _preferences?.getString("reports");
  }
}
