import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/screens/reports_page.dart';
import '../data/service.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.service}) : super(key: key);
  final ProductService service;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    widget.service.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.service,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "MAAB",
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const ReportsPage(),
        );
      },
    );
  }
}
