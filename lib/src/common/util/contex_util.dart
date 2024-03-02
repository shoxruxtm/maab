import 'package:flutter/material.dart';

extension ContextUtil on BuildContext{
    TextTheme get textTheme =>Theme.of(this).textTheme;
}