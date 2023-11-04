import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width(.04)),
          child: Column(
            children: [
              SizedBox(height: context.height(.02)),
              Circle(
                  width: context.height(.08),
                  color: AppColors.accent,
                  child: Center(
                      child: Text(
                    "P",
                    style: TextStyle(
                      fontSize: context.width(.12),
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ))),
              SizedBox(height: context.height(.015)),
              Text(
                "Staunch Nova",
                style: TextStyle(
                  fontSize: context.width(.055),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: context.height(.02)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "08112344321",
                    style: TextStyle(
                      fontSize: context.width(.045),
                    ),
                  ),
                  SizedBox(width: context.width(.02)),
                  SvgPicture.asset(ImageUtil.squigly_check)
                ],
              ),
              SizedBox(height: context.height(.06)),
              ProfileItemsWidget(
                onTap: () {},
                title: "Edit Personal details",
                subtitle: "Image, Phone, Email and password",
                icon: ImageUtil.person,
              ),
              ProfileItemsWidget(
                onTap: () {},
                title: "Notification Setting",
                subtitle: "Set your alerts and means of notification",
                icon: ImageUtil.fancy_notification,
              ),
              ProfileItemsWidget(
                onTap: () {},
                title: "Log out",
                icon: ImageUtil.logout,
              ),
              ProfileItemsWidget(
                onTap: () {},
                title: "Delete account",
                icon: ImageUtil.delete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
