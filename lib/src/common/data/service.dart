import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maab/src/common/model/product_model.dart';
import 'package:maab/src/common/model/resource_model.dart';
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
    return _reports!
      ..sort(
        (a, b) => a.date.compareTo(b.date),
      );
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

class ProductGenerate {
  final TextEditingController textEditingController;
  ProductModel product;
   ValueNotifier<String?> name;

  ProductGenerate()
      : textEditingController = TextEditingController(text: "0"),
        product = ProductModel(),name=ValueNotifier(null);

  void dispose() {
    textEditingController.dispose();
    name.dispose();
  }

  ProductModel? validate() {
    if (textEditingController.text.isNotEmpty) {
      product.itemCount = int.tryParse(textEditingController.text) ?? 0;
    }
    product.name = name.value;
    return product.validate() ? product : null;
  }

  void setName(String name) {
    this.name.value = name;
  }
}

class ResourceGenerate {
  final TextEditingController textEditingController;
  ResourceModel resource;
  ValueNotifier<String?> name;

  ResourceGenerate()
      : textEditingController = TextEditingController(text: "0"),
        resource = ResourceModel(), name = ValueNotifier(null);

  void dispose() {
    textEditingController.dispose();
    name.dispose();
  }

  ResourceModel? validate() {
    if (textEditingController.text.isNotEmpty) {
      resource.amount = double.tryParse(textEditingController.text) ?? 0;
    }
    resource.name = name.value;
    return resource.validate() ? resource : null;
  }

  void setName(String name) {
    this.name.value = name;
  }
}

extension ProductListExtension on List<ProductGenerate> {
  List<ProductModel> toProductList() {
    return map((e) {
      final product = e.validate();
      if (product == null) {
        throw "Barcha productlarga qiymat berish kerak";
      } else {
        return product;
      }
    }).toList();
  }

  void dispose(){
    for(var i in this){
      i.dispose();
    }
  }
}

extension ResourceListExtension on List<ResourceGenerate> {
  List<ResourceModel> toResourceList() {
    return map((e) {
      final resource = e.validate();
      if (resource == null) {
        throw "Barcha resourcelarga qiymat berish kerak";
      } else {
        return resource;
      }
    }).toList();
  }

  void dispose(){
    for(var i in this){
      i.dispose();
    }
  }
}
