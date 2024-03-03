import 'package:flutter/material.dart';

import '../../common/model/product_model.dart';
import '../../common/model/resource_model.dart';
import 'add_product_page.dart';

mixin AddProductMixin on State<AddProductPage>{
  late final TextEditingController textEditingController;
  late final TextEditingController textEditingController1;
  late final TextEditingController textEditingController2;
  late final TextEditingController textEditingController3;
  late final TextEditingController textEditingController4;
  late final TextEditingController textEditingController5;
  late final TextEditingController textEditingController6;
  late final TextEditingController textEditingController7;

  late final ValueNotifier<String?> name;

  final ExpansionTileController expansionTileController =
  ExpansionTileController();

  List<String> names = ["Odil", "Shaxzod", "Said", "Rasul"];

  late List<TextEditingController> productControllers = [
    textEditingController,
    textEditingController1,
    textEditingController2,
    textEditingController3,
  ];
  late List<TextEditingController> resourceController = [
    textEditingController4,
    textEditingController5,
    textEditingController6,
    textEditingController7,
  ];

  @override
  void initState() {
    name = ValueNotifier(null);
    textEditingController = TextEditingController();
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
    textEditingController3 = TextEditingController();
    textEditingController4 = TextEditingController();
    textEditingController5 = TextEditingController();
    textEditingController6 = TextEditingController();
    textEditingController7 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    textEditingController.dispose();
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();
    textEditingController4.dispose();
    textEditingController5.dispose();
    textEditingController6.dispose();
    textEditingController7.dispose();
  }

  List<ProductModel> productList = [];
  List<ResourceModel> resourceList = [];

  List<String> products = ["table", "chair", "vanna", "gorshok"];
  List<String> resource = ["pp", "lp", "kk", "lo"];
}