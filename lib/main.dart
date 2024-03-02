import 'package:flutter/material.dart';

import 'src/common/data/service.dart';
import 'src/common/widget/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ProductService.init();
  runApp(const MyApp());
}
