import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/models.dart';

class ProductService with ChangeNotifier {
  ProductService._(this._preferences);

  static const _reportKey = 'all-reports';

  final SharedPreferences _preferences;
  List<AllReports>? _reports;

  static Future<ProductService> init() async {
    final pref = await SharedPreferences.getInstance();
    // pref.clear();
    return ProductService._(pref);
  }

  int? getByDate(DateTime date) {
    final index = getReports.indexWhere((e) =>
        e.date.year == date.year &&
        e.date.month == date.month &&
        e.date.day == date.day);
    return index.isNegative ? null : index;
  }

  List<ReportModel> getReportsByDay(DateTime date) {
    final index = getByDate(date);
    if (index == null) {
      return [];
    } else {
      return getReports[index].reports
        ..sort(
          (a, b) => a.date.compareTo(b.date),
        );
    }
  }

  Future<void> addReport(ReportModel report) async {
    final allReportByDay = getByDate(report.date);
    if (allReportByDay == null) {
      final currentReports = AllReports(
          reports: [report],
          date: report.date.copyWith(
            hour: 0,
            microsecond: 0,
            millisecond: 0,
            minute: 0,
            second: 0,
          ));
      _reports!.add(currentReports);
    } else {
      getReports[allReportByDay].reports.add(report);
    }
    _preferences.setStringList(
        _reportKey, _reports!.map((e) => jsonEncode(e.toJson())).toList());
    notifyListeners();
  }

  List<AllReports> get getReports {
    _reports ??= (_preferences.getStringList(_reportKey) ?? [])
        .map((e) => AllReports.fromJson(jsonDecode(e)))
        .toList();
    return _reports!..sort((a, b) => a.date.compareTo(b.date),);
  }
}

class AllReports {
  DateTime date;
  List<ReportModel> reports;

  AllReports({
    required this.reports,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  Map<String, Object?> toJson() {
    return {
      'reports': reports.map((e) => e.toJson()).toList(),
      'date': date.toIso8601String(),
    };
  }

  factory AllReports.fromJson(Map<String, Object?> map) {
    return AllReports(
      reports: ((map['reports'] as List?) ?? [])
          .cast<Map>()
          .map((e) => ReportModel.fromJson(e.cast<String, Object?>()))
          .toList(),
      date: map['date'] != null ? DateTime.parse(map['date'] as String) : null,
    );
  }
}
