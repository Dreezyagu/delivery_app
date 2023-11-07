import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';

class ProfileItemsWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String? subtitle;
  final String icon;

  const ProfileItemsWidget(
      {super.key,
      required this.onTap,
      required this.title,
      this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return WhitePill(
        borderRadius: 20,
        margin: EdgeInsets.symmetric(vertical: context.height(.01)),
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(
              vertical: subtitle == null
                  ? context.height(.012)
                  : context.height(.007),
              horizontal: context.width(.02)),
          leading: SvgPicture.asset(
            icon,
            height: icon == ImageUtil.delete
                ? context.width(.05)
                : context.width(.055),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: context.width(.04),
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: subtitle == null
              ? null
              : Text(
                  subtitle ?? "",
                  style: TextStyle(
                    fontSize: context.width(.033),
                    fontWeight: FontWeight.w400,
                  ),
                ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: context.width(.04),
            color: const Color(0xff0888B3).withOpacity(.32),
          ),
        ));
  }
}
