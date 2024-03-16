import 'package:flutter/material.dart';

import '../../common/data/service.dart';

class CustomProduct extends StatelessWidget {
  const CustomProduct({super.key, required this.productGenerate});

  final ProductGenerate productGenerate;
  static List<String> products = ["table", "chair", "vanna", "gorshok"];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder(
            valueListenable: productGenerate.name,
            builder: (context, value, _) {
              return SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  value: value,
                  hint: const Text(""),
                  items: products
                      .map(
                        (e) =>
                        DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                  )
                      .toList(),
                  onChanged: (String? value) {
                    productGenerate.name.value = value;
                  },
                ),
              );
            }),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: productGenerate.textEditingController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}
