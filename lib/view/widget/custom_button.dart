import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final double high;
  final double width;
  final double borderRadius;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    required this.child,
    required this.width,
    required this.borderRadius,
    required this.high,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: high,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    );
  }
}
