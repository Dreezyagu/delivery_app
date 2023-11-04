import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';

class HomepageWhitepill extends StatelessWidget {
  const HomepageWhitepill({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.padding,
  });

  final String icon;
  final String title;
  final VoidCallback onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: WhitePill(
          padding: padding ??
              EdgeInsets.symmetric(
                  horizontal: context.width(.02), vertical: context.width(.03)),
          child: Row(
            children: [
              Circle(
                  width: context.width(.1),
                  color: AppColors.primary.withOpacity(.38),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(icon),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width(.025)),
                child: Text(
                  title,
                  style: TextStyle(fontSize: context.width(.033)),
                ),
              )
            ],
          )),
    );
  }
}
