import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';

class DeliveryWhitepill extends StatelessWidget {
  const DeliveryWhitepill({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.padding,
    required this.selected,
  });

  final String icon;
  final String title;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: WhitePill(
          boxBorder:
              selected ? Border.all(color: AppColors.primary, width: 4) : null,
          padding: padding ??
              EdgeInsets.symmetric(
                  horizontal: context.width(.01), vertical: context.width(.01)),
          child: Row(
            children: [
              Circle(
                  width: context.width(.09),
                  color: AppColors.primary.withOpacity(.38),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(icon),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width(.025)),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: context.width(.03),
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          )),
    );
  }
}
