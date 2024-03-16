import 'package:flutter/material.dart';
import '../../common/util/context_util.dart';
import '../../features/widgets/custom_button.dart';
import '../widgets/reports.dart';

class AddReportsPage extends StatefulWidget {
  const AddReportsPage({Key? key}) : super(key: key);

  @override
  State<AddReportsPage> createState() => _AddReportsPageState();
}

class _AddReportsPageState extends State<AddReportsPage> {
  DateTime date = DateTime.now();

  String s = '';

  late List<Reports> reportWidget = [
    Reports(
      key: keys[0],
    )
  ];

  List<GlobalKey<ReportsState>> keys = [GlobalKey<ReportsState>()];

  late final ValueNotifier<DateTime?> dateTime;

  @override
  void initState() {
    dateTime = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    dateTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
            valueListenable: dateTime,
            builder: (context, value, _) {
              return Text(
                value == null
                    ? "Report Create(${date.month}-${date.day}-${date.year})"
                    : "Report Create(${value.month}-${value.day}-${value.year})",
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              );
            }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            children: [
              CustomButton(
                child: ValueListenableBuilder(
                    valueListenable: dateTime,
                    builder: (context, value, _) {
                      return Text(
                        value == null
                            ? "Report Create(${date.month}-${date.day}-${date.year})"
                            : "Report Create(${value.month}-${value.day}-${value.year})",
                        style: context.textTheme.titleLarge,
                      );
                    }),
                onPressed: () async {
                  DateTime? _picker = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (_picker != null) {
                    setState(() {
                      date = _picker;
                    });
                  }
                },
              ),
              ListView.builder(
                itemBuilder: (context, index) {
                  return reportWidget[index];
                },
                itemCount: reportWidget.length,
                shrinkWrap: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                child: const Text("Add Employes"),
                onPressed: () {
                  final globalKey = GlobalKey<ReportsState>();
                  reportWidget.add(Reports(
                    key: globalKey,
                  ));
                  keys.add(globalKey);
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 100,
              ),
              CustomButton(
                child: const Text("Save"),
                onPressed: () async {
                  bool isSuccess = true;
                  for (int i = 0; i < reportWidget.length; i++) {
                    if (!(keys[i].currentState?.validate() ?? false)) {
                      isSuccess = false;
                      break;
                    }
                  }
                  if (isSuccess) {
                    for (int i = 0; i < reportWidget.length; i++) {
                      await (keys[i]).currentState?.save(date);
                    }
                    Navigator.pop(context);
                  }
                },
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
