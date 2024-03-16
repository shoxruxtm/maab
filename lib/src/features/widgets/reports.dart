import 'package:flutter/material.dart';
import 'package:maab/src/common/util/context_util.dart';
import 'package:provider/provider.dart';

import '../../common/data/service.dart';
import '../../common/model/models.dart';
import 'custom_button.dart';
import 'products.dart';
import 'resource.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => ReportsState();
}

class ReportsState extends State<Reports> {
  final ExpansionTileController expansionTileController =
      ExpansionTileController();

  late final ValueNotifier<String?> name;

  List<String> names = ["Odil", "Shaxzod", "Said", "Rasul"];

  List<ProductGenerate> productGenerate = [ProductGenerate()];
  List<ResourceGenerate> resourceGenerate = [ResourceGenerate()];

  @override
  void initState() {
    name = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    productGenerate.dispose();
    resourceGenerate.dispose();
    name.dispose();
    super.dispose();
  }

  bool validate() {
    if (name.value != null) {
      try {
        productGenerate.toProductList();
        resourceGenerate.toResourceList();
        return true;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
        return false;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Name is not selected",
          ),
        ),
      );
      return false;
    }
  }

  Future<void> save(DateTime dateTime) async {
    final reportModel = ReportModel(
      name: name.value!,
      resourceList: resourceGenerate.toResourceList(),
      productList: productGenerate.toProductList(),
      date: dateTime,
    );
    await context.read<ProductService>().addReport(reportModel);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
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
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CustomProduct(productGenerate: productGenerate[index]);
          },
          itemCount: productGenerate.length,
        ),
        CustomButton(
          child: const Text("Add Product"),
          onPressed: () {
            if (productGenerate.length <= 3) {
              productGenerate.add(ProductGenerate());
              setState(() {});
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CustomResource(resourceGenerate: resourceGenerate[index]);
          },
          itemCount: resourceGenerate.length,
        ),
        CustomButton(
          child: const Text("Add Resource"),
          onPressed: () {
            if (resourceGenerate.length <= 3) {
              resourceGenerate.add(ResourceGenerate());
              setState(() {});
            }
          },
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
