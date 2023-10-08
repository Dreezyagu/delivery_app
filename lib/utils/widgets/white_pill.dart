import 'package:flutter/material.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';

class WhitePill extends StatelessWidget {
  final double? width, height, borderRadius;
  final Widget child;
  final EdgeInsets? padding;
  final BoxBorder? boxBorder;
  final Color? color;

  const WhitePill(
      {super.key,
      this.width,
      this.height,
      required this.child,
      this.padding,
      this.borderRadius,
      this.boxBorder,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding ?? EdgeInsets.symmetric(horizontal: context.width(.02)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 50),
          border: boxBorder,
          color: color ?? AppColors.white),
      child: child,
    );
  }
}
