import 'package:flutter/material.dart';

import '../../common/constant/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.child,
    this.size,
    required this.onPressed,
    this.shape,
  });

  final Widget child;
  final Size? size;
  final OutlinedBorder? shape;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        minimumSize: MaterialStateProperty.all(size),
        maximumSize: MaterialStateProperty.all(size),
        fixedSize: MaterialStateProperty.all(size),
        shape: MaterialStateProperty.all(shape),
      ),
      child: child,
    );
  }
}
