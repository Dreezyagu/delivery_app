import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_textfield.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary_light,
      appBar: AppBar(elevation: 0, backgroundColor: AppColors.primary_light),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width(.06)),
        child: Column(
          children: [
            SvgPicture.asset(ImageUtil.main_icon_light),
            SizedBox(height: context.height(.05)),
            Text(
              "Sign up",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: context.width(.045), fontWeight: FontWeight.w700),
            ),
            SizedBox(height: context.height(.03)),
            CustomTextFormField(
              controller: emailController,
              hintText: "Name",
              prefix: Container(
                margin: EdgeInsets.only(
                    left: context.width(.06), right: context.width(.03)),
                child: SvgPicture.asset(
                  ImageUtil.person,
                ),
              ),
            ),
            SizedBox(height: context.height(.02)),
            CustomTextFormField(
              controller: emailController,
              hintText: "Phone number",
              prefix: Container(
                margin: EdgeInsets.only(
                    left: context.width(.06), right: context.width(.03)),
                child: SvgPicture.asset(
                  ImageUtil.phone_number,
                ),
              ),
            ),
            SizedBox(height: context.height(.02)),
            CustomTextFormField(
              controller: emailController,
              hintText: "Email",
              prefix: Container(
                margin: EdgeInsets.only(
                    left: context.width(.06), right: context.width(.03)),
                child: SvgPicture.asset(
                  ImageUtil.email,
                ),
              ),
            ),
            SizedBox(height: context.height(.02)),
            CustomTextFormField(
              controller: passwordController,
              hintText: "Password",
              prefix: Container(
                margin: EdgeInsets.only(
                    left: context.width(.06), right: context.width(.03)),
                child: SvgPicture.asset(
                  ImageUtil.password,
                ),
              ),
              suffix: Padding(
                padding: EdgeInsets.only(right: context.width(.02)),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility_outlined,
                      color: AppColors.hintColor,
                      size: context.width(.05),
                    )),
              ),
            ),
            SizedBox(height: context.height(.02)),
            CustomTextFormField(
              controller: passwordController,
              hintText: "Confirm password",
              prefix: Container(
                margin: EdgeInsets.only(
                    left: context.width(.06), right: context.width(.03)),
                child: SvgPicture.asset(
                  ImageUtil.password,
                ),
              ),
              suffix: Padding(
                padding: EdgeInsets.only(right: context.width(.02)),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility_outlined,
                      color: AppColors.hintColor,
                      size: context.width(.05),
                    )),
              ),
            ),
            SizedBox(height: context.height(.04)),
            CustomContinueButton2(
              onPressed: () {},
              sidePadding: 0,
              elevation: 0,
              bgColor: AppColors.accent,
              title: "Sign up",
            ),
            SizedBox(height: context.height(.01)),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Text(
                "Sign in instead",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: context.width(.037),
                    color: AppColors.hintColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
