import 'package:flutter/material.dart';
import 'package:ojembaa_mobile/features/authentication/screens/login_page.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Container(
        width: double.infinity,
        height: context.height(.4),
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Ojembaa",
              style: TextStyle(
                  fontSize: context.width(.065), fontWeight: FontWeight.w700),
            ),
            SizedBox(height: context.height(.01)),
            Text(
              "Life is easier when you have\nsomeone to help",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: context.width(.04), fontWeight: FontWeight.w400),
            ),
            SizedBox(height: context.height(.03)),
            CustomContinueButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: "/loginPage"),
                      builder: (context) => const LoginPage(),
                    ));
              },
              title: "Get started",
            )
          ],
        ),
      ),
    );
  }
}
