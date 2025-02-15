// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ojembaa_mobile/features/authentication/providers/signin_provider.dart';
import 'package:ojembaa_mobile/features/authentication/screens/forgot_password.dart';
import 'package:ojembaa_mobile/features/authentication/screens/signup_page.dart';
import 'package:ojembaa_mobile/features/homepage/providers/get_location_provider.dart';
import 'package:ojembaa_mobile/features/homepage/screens/nav_page.dart';
import 'package:ojembaa_mobile/features/orders/providers/get_orders_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/get_categories_provider.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/helpers/storage/storage_helper.dart';
import 'package:ojembaa_mobile/utils/helpers/storage/storage_keys.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_textfield.dart';
import 'package:ojembaa_mobile/utils/widgets/snackbar.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscure = true;

  bool? rememberMe = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bannerExpanded = MediaQuery.viewInsetsOf(context).bottom <= 10;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.width(.06)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: context.height(.03)),
                        SvgPicture.asset(
                          ImageUtil.icon_title_accent,
                        ),
                        SizedBox(height: context.height(.048)),
                        Text(
                          "Sign In",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: context.width(.045),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: context.height(.02)),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: "Email",
                          prefix: Container(
                            margin: EdgeInsets.only(
                                left: context.width(.06),
                                right: context.width(.03)),
                            child: SvgPicture.asset(
                              ImageUtil.email,
                            ),
                          ),
                        ),
                        SizedBox(height: context.height(.03)),
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: "Password",
                          obscureText: obscure,
                          prefix: Container(
                            margin: EdgeInsets.only(
                                left: context.width(.06),
                                right: context.width(.03)),
                            child: SvgPicture.asset(
                              ImageUtil.password,
                            ),
                          ),
                          suffix: Padding(
                            padding: EdgeInsets.only(right: context.width(.02)),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                icon: Icon(
                                  !obscure
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.hintColor,
                                  size: context.width(.05),
                                )),
                          ),
                        ),
                        SizedBox(height: context.height(.01)),
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value;
                                });
                              },
                            ),
                            Text(
                              "Remember me",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: context.width(.04),
                                  fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword(),
                                    ));
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Forgot password?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.red,
                                      fontSize: context.width(.04),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.height(.025)),
                        Consumer(
                          builder: (context, ref, child) {
                            final watcher = ref.watch(signInProvider);
                            final reader = ref.read(signInProvider.notifier);
                            return CustomContinueButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                StorageHelper.setBoolean(
                                    StorageKeys.rememberMeKey, rememberMe);
                                if (_formKey.currentState?.validate() == true) {
                                  reader.signIn(
                                      onError: (p0) =>
                                          CustomSnackbar.showErrorSnackBar(
                                              context,
                                              message: p0),
                                      onSuccess: () async {
                                        ref
                                            .read(getOrdersProvider.notifier)
                                            .getOrders();
                                        ref
                                            .read(
                                                getCategoriesProvider.notifier)
                                            .fetchCategories();

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              settings: const RouteSettings(
                                                  name: "/mainPage"),
                                              builder: (context) =>
                                                  const NavPage(),
                                            ));

                                        final permission = await Geolocator
                                            .requestPermission();
                                        if (permission !=
                                                LocationPermission.denied &&
                                            permission !=
                                                LocationPermission
                                                    .deniedForever) {
                                          ref
                                              .read(
                                                  getLocationProvider.notifier)
                                              .getCurrentLocation();
                                        }
                                      },
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim());
                                }
                              },
                              isActive: !watcher.isLoading,
                              sidePadding: 0,
                              elevation: 0,
                              bgColor: AppColors.accent,
                              title: "Sign In",
                            );
                          },
                        ),
                        SizedBox(height: context.height(.02)),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupPage(),
                                ));
                          },
                          child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: context.width(.037),
                                      color: AppColors.black),
                                  children: const [
                                TextSpan(text: "Don't have an account?"),
                                TextSpan(
                                    text: " Sign up",
                                    style: TextStyle(color: AppColors.red)),
                              ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (bannerExpanded)
            Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  ImageUtil.big_icon_transparent,
                  height: context.height(.3),
                ))
        ],
      ),
    );
  }
}
