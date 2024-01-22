import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/authentication/providers/signin_provider.dart';
import 'package:ojembaa_mobile/features/profile/widgets/profile_items_widget.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(signInProvider).data;
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
                    "${profileData?.firstName?.substring(0, 1)}",
                    style: TextStyle(
                      fontSize: context.width(.12),
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ))),
              SizedBox(height: context.height(.015)),
              Text(
                "${profileData?.firstName} ${profileData?.lastName}",
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
                    "${profileData?.phone}",
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
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.white,
                      title: Text(
                        "Log out",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: context.width(.045)),
                      ),
                      content: Text(
                        "Are you sure you want to log out?",
                        style: TextStyle(fontSize: context.width(.04)),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "No",
                              style: TextStyle(fontSize: context.width(.038)),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.popUntil(
                                  context, ModalRoute.withName("/loginPage"));
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(fontSize: context.width(.038)),
                            )),
                      ],
                    ),
                  );
                },
                title: "Log out",
                icon: ImageUtil.logout,
              ),
              ProfileItemsWidget(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      backgroundColor: AppColors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.width(.06),
                            vertical: context.width(.06)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delete account",
                              style: TextStyle(
                                  fontSize: context.width(.05),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black),
                            ),
                            SizedBox(height: context.width(.03)),
                            Text.rich(
                              TextSpan(
                                  text:
                                      "We are sorry to see you leaving. Kindly contact ",
                                  style: TextStyle(
                                      fontSize: context.width(.04),
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                      color: AppColors.black),
                                  children: const [
                                    TextSpan(
                                      text: "hello@ojembaa.com",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary),
                                    ),
                                    TextSpan(text: " to complete this process.")
                                  ]),
                            ),
                            SizedBox(height: context.width(.06)),
                            CustomContinueButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              title: "Okay",
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
