import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/data/service.dart';
import '../../common/model/product_model.dart';
import '../widgets/custom_button.dart';
import 'add_product_page.dart';
import 'product_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    response = ProductService.getReport() ?? "";
    log(response.toString());
  }

  String response = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddProductPage(),
          ),
        ),
        size: const Size(40, 40),
        shape: const CircleBorder(),
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 50,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset("assets/icons/image 3 (1).png"),
        ),
        actions: [
          CustomButton(
            onPressed: () {},
            size: const Size(40, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              "assets/icons/Vector.svg",
            ),
          ),
        ],
      ),
      body: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: List.generate(
                1,
                (i) => ListTile(
                  title: Text(DateTime.now().toString()),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        currentProduct:
                            ProductModel.fromJson(jsonDecode(response)).name,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
