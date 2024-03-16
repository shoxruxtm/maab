import 'package:flutter/material.dart';
import 'package:maab/src/features/screens/add_reports.dart';
import 'package:provider/provider.dart';

import '../../common/constant/app_colors.dart';
import '../../common/util/context_util.dart';
import '../../common/data/service.dart';
import '../widgets/custom_button.dart';
import 'product_page.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddReportsPage(),
          ),
        ),
        size: const Size(55, 55),
        shape: const CircleBorder(),
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Reports",
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Consumer<ProductService>(
              builder: (context, value, child) {
                final reports = value.getReports;
                return ListView.separated(
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    final report = reports.elementAt(index);
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: productColor,
                      splashColor: productColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      title: Text(
                        "${report.date.month}-${report.date.day}-${report.date.year}",
                        style: context.textTheme.titleLarge,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(date: report.date),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
