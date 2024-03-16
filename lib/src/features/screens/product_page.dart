import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../common/constant/app_colors.dart';
import '../../common/data/service.dart';
import '../../common/util/context_util.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.date});

  final DateTime date;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Report (${widget.date.month}-${widget.date.day}-${widget.date.year})",
        ),
      ),
      body: Consumer<ProductService>(
        builder: (context, value, child) {
          final reports = value.getReportsByDay(widget.date);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final report = reports.elementAt(index);
                return SizedBox(
                  child: Card(
                    color: productColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListTile(
                            title: Text(
                              "Employes",
                              style: context.textTheme.titleMedium,
                            ),
                            trailing: Text(
                              report.name,
                              style: context.textTheme.titleMedium,
                            ),
                          ),
                        ),
                        const Divider(
                          indent: 16,
                          endIndent: 16,
                        ),
                        ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            indent: 16,
                            endIndent: 16,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final product =
                                report.productList!.elementAt(index);
                            return SizedBox(
                              height: 40,
                              child: ListTile(
                                title: Text(
                                  product.name!,
                                  style: context.textTheme.titleMedium,
                                ),
                                trailing: Text(
                                  "${product.itemCount.toString()} items",
                                  style: context.textTheme.titleMedium,
                                ),
                              ),
                            );
                          },
                          itemCount: report.productList?.length ?? 0,
                        ),
                        const Divider(
                          indent: 16,
                          endIndent: 16,
                        ),
                        ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            indent: 16,
                            endIndent: 16,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final product =
                                report.resourceList!.elementAt(index);
                            return SizedBox(
                              height: 40,
                              child: ListTile(
                                title: Text(
                                  product.name!,
                                  style: context.textTheme.titleMedium,
                                ),
                                trailing: Text(
                                  "${product.amount.toString()} kg",
                                  style: context.textTheme.titleMedium,
                                ),
                              ),
                            );
                          },
                          itemCount: report.resourceList?.length ?? 0,
                        ),
                        const Divider(
                          indent: 16,
                          endIndent: 16,
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: reports.length,
            ),
          );
        },
      ),
    );
  }
}
