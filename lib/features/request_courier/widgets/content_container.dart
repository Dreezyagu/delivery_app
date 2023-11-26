import 'package:flutter/material.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';

enum DeliveryType { light, medium, heavy }

enum Recipient { me, thirdParty }

class ContentContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const ContentContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ??
          EdgeInsets.symmetric(
              horizontal: context.width(.04), vertical: context.height(.015)),
      decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(.12),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
