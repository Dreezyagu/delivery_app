import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/authentication/providers/signin_provider.dart';
import 'package:ojembaa_mobile/features/authentication/screens/login_page.dart';
import 'package:ojembaa_mobile/features/profile/widgets/profile_items_widget.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/helpers/storage/storage_helper.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_textfield.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
              // ProfileItemsWidget(
              //   onTap: () {},
              //   title: "Edit Personal details",
              //   subtitle: "Image, Phone, Email and password",
              //   icon: ImageUtil.person,
              // ),
              // ProfileItemsWidget(
              //   onTap: () {},
              //   title: "Notification Setting",
              //   subtitle: "Set your alerts and means of notification",
              //   icon: ImageUtil.fancy_notification,
              // ),
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
                              StorageHelper.clearPreferences();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    settings:
                                        const RouteSettings(name: "/loginPage"),
                                    builder: (context) => const LoginPage(),
                                  ));
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
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.white,
                      title: Text(
                        "Delete Account",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: context.width(.045)),
                      ),
                      content: Text(
                        "Are you sure you want to delete your account?",
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
                              Navigator.pop(context);
                              showModalBottomSheet(
                                context: context,
                                isDismissible: false,
                                enableDrag: false,
                                builder: (context) => StatefulBuilder(
                                    builder: (context, setState) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 24),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Kindly enter your password",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: context.width(.045)),
                                        ),
                                        const SizedBox(height: 30),
                                        CustomTextFormField(
                                          controller: passwordController,
                                          hintText: "Password",
                                          obscureText: true,
                                          prefix: Container(
                                            margin: EdgeInsets.only(
                                                left: context.width(.06),
                                                right: context.width(.03)),
                                            child: SvgPicture.asset(
                                              ImageUtil.password,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 60),
                                        CustomContinueButton(
                                          onPressed: () async {
                                            if (passwordController
                                                .text.isNotEmpty) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              await StorageHelper
                                                  .clearPreferences();
                                              Future.delayed(
                                                const Duration(seconds: 90),
                                                () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        settings:
                                                            const RouteSettings(
                                                                name:
                                                                    "/loginPage"),
                                                        builder: (context) =>
                                                            const LoginPage(),
                                                      ));
                                                },
                                              );
                                            }
                                          },
                                          isActive: !isLoading,
                                          title: "Delete Account",
                                          sidePadding: 0,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              );
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(fontSize: context.width(.038)),
                            )),
                      ],
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
