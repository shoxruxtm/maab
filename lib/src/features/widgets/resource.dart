import 'package:flutter/material.dart';

import '../../common/data/service.dart';

class CustomResource extends StatelessWidget {
  const CustomResource({super.key, required this.resourceGenerate});

  final ResourceGenerate resourceGenerate;

  static List<String> resources = ["pp", "lp", "kk", "lo"];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder(
            valueListenable: resourceGenerate.name,
            builder: (context, value, _) {
              return SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  value: value,
                  hint: const Text(""),
                  items: resources
                      .map(
                        (e) =>
                        DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                  )
                      .toList(),
                  onChanged: (String? value) {
                    resourceGenerate.name.value = value;
                  },
                ),
              );
            }),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: resourceGenerate.textEditingController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}
