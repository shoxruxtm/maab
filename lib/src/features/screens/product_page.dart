import 'dart:convert';

import 'package:flutter/material.dart';

import '../../common/model/models.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.currentProduct});

  final String currentProduct;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late final ReportModel reportModel;

  @override
  void initState() {
    reportModel =
        ReportModel.fromJson(jsonDecode(widget.currentProduct));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateTime.now().toString(),
        ),
      ),
      body: Column(
        children: [
          Text(reportModel.name),
        ],
      ),
    );
  }
}
