import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:maab/src/common/util/context_util.dart';
import 'package:provider/provider.dart';

import '../../common/data/service.dart';
import '../../common/model/models.dart';
import '../../common/model/product_model.dart';
import '../../common/model/resource_model.dart';
import '../widgets/custom_button.dart';
import 'add_product_mixin.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> with AddProductMixin {
  final date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Report Create(${date.month}-${date.day}-${date.year})",
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            children: [
              ExpansionTile(
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                collapsedBackgroundColor: Colors.black12,
                backgroundColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                childrenPadding: const EdgeInsets.only(left: 18),
                expandedAlignment: Alignment.centerLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                controller: expansionTileController,
                title: ValueListenableBuilder(
                    valueListenable: name,
                    builder: (context, value, _) {
                      return Text(
                        value ?? "Employes",
                        style: context.textTheme.titleLarge,
                      );
                    }),
                children: List.generate(
                  names.length,
                  (i) {
                    return SizedBox(
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          name.value = names[i];
                          expansionTileController.collapse();
                        },
                        child: Text(
                          names[i],
                          style: context.textTheme.titleLarge,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ExpansionTile(
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                collapsedBackgroundColor: Colors.black12,
                backgroundColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(
                  "Product",
                  style: context.textTheme.titleLarge,
                ),
                children: List.generate(products.length, (i) {
                  return SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          products[i],
                          style: context.textTheme.titleLarge,
                        ),
                        const SizedBox(
                          width: 150,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 60,
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: productControllers[i],
                              ),
                            ),
                            Text(
                              "items",
                              style: context.textTheme.titleMedium,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              ExpansionTile(
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                collapsedBackgroundColor: Colors.black12,
                backgroundColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(
                  "Resource",
                  style: context.textTheme.titleLarge,
                ),
                children: List.generate(
                  resource.length,
                  (i) => SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          resource[i],
                          style: context.textTheme.titleLarge,
                        ),
                        const SizedBox(
                          width: 150,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 60,
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: resourceController[i],
                              ),
                            ),
                            Text(
                              "kg",
                              style: context.textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              CustomButton(
                size: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Add Report",
                  style: context.textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (name.value == null) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text("Employes is not selected"),
                        ),
                      );
                    return;
                  }
                  ReportModel report = ReportModel(
                    name: name.value!,
                    resourceList: resource
                        .map(
                          (e) => ResourceModel(
                            name: e,
                            amount: double.tryParse(resourceController
                                    .elementAt(resource.indexOf(e))
                                    .text) ??
                                0.0,
                          ),
                        )
                        .toList(),
                    productList: products.map((e) {
                      return ProductModel(
                        name: e,
                        itemCount: int.tryParse(productControllers
                                .elementAt(products.indexOf(e))
                                .text) ??
                            0,
                      );
                    }).toList(),
                  );
                  log("reports => $report");
                  context.read<ProductService>().addReport(report);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
