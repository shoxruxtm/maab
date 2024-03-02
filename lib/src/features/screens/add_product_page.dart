import 'dart:developer';

import 'package:flutter/material.dart';

import '../../common/data/service.dart';
import '../../common/model/models.dart';
import '../../common/model/product_model.dart';
import '../../common/model/resource_model.dart';
import '../widgets/custom_button.dart';
import 'main_page.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  static TextEditingController textEditingController = TextEditingController();
  static TextEditingController textEditingController1 = TextEditingController();
  static TextEditingController textEditingController2 = TextEditingController();
  static TextEditingController textEditingController3 = TextEditingController();
  static TextEditingController textEditingController4 = TextEditingController();
  static TextEditingController textEditingController5 = TextEditingController();
  static TextEditingController textEditingController6 = TextEditingController();
  static TextEditingController textEditingController7 = TextEditingController();

  TextEditingController controller = TextEditingController();

  final ExpansionTileController expansionTileController =
      ExpansionTileController();

  String name = "";

  List<String> names = ["Odil", "Shaxzod", "Said", "Rasul"];

  List productControllers = [
    textEditingController,
    textEditingController1,
    textEditingController2,
    textEditingController3,
  ];
  List resourceController = [
    textEditingController4,
    textEditingController5,
    textEditingController6,
    textEditingController7,
  ];

  @override
  void initState() {
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
    textEditingController.dispose();
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();
    textEditingController4.dispose();
    textEditingController5.dispose();
    textEditingController6.dispose();
    textEditingController7.dispose();
    controller.dispose();
  }

  List<ProductModel> productList = [];
  List<ResourceModel> resourceList = [];

  List<String> products = ["table", "chair", "Vanna", "gorshok"];
  List<String> resource = ["pp", "lp", "kk", "lo"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            children: [
              ExpansionTile(
                  controller: expansionTileController,
                  shape: const RoundedRectangleBorder(side: BorderSide.none),
                  title: const Text("Employes"),
                  children: List.generate(names.length, (i) {
                    return SizedBox(
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          name = names[i];
                          expansionTileController.collapse();
                        },
                        child: Text(names[i]),
                      ),
                    );
                  })),
              const SizedBox(
                height: 20,
              ),
              ExpansionTile(
                shape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                ),
                title: const Text("Product"),
                children: List.generate(products.length, (i) {
                  return SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Text(products[i]),
                        const SizedBox(
                          width: 150,
                        ),
                        SizedBox(
                          height: 20,
                          width: 60,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onTap: () {
                              controller = TextEditingController();
                            },
                            controller: productControllers[i],
                            onTapOutside: (event) {
                              final productModel = ProductModel(
                                name: resource[i],
                                itemCount:
                                    int.tryParse(productControllers[i].text) ??
                                        0,
                              );
                              productList.add(productModel);
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              ExpansionTile(
                shape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                ),
                title: const Text("Resource"),
                children: List.generate(
                  resource.length,
                  (i) => SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Text(resource[i]),
                        const SizedBox(
                          width: 150,
                        ),
                        SizedBox(
                          height: 20,
                          width: 60,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: resourceController[i],
                            onTapOutside: (event) {
                              final resourceModel = ResourceModel(
                                name: resource[i],
                                amount: double.tryParse(
                                        resourceController[i].text) ??
                                    0.0,
                              );
                              resourceList.add(resourceModel);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              CustomButton(
                child: const Text("done"),
                onPressed: () {
                  ReportModel report = ReportModel(
                    name: name,
                    resourceList: resourceList,
                    productList: productList,
                  );
                  log("reports => $report");
                  ProductService.createReport(newReport: report);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
