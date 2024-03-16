import 'package:flutter/material.dart';

import 'src/common/data/service.dart';
import 'src/common/widget/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final service = await ProductService.init();
  runApp(
    MyApp(
      service: service,
    ),
  );
}
