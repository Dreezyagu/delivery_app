import 'package:flutter/material.dart';
import 'package:ojembaa_mobile/features/preliminary/widgets/welcome_widget.dart';
import 'package:ojembaa_mobile/utils/colors.dart';
import 'package:ojembaa_mobile/utils/extensions.dart';
import 'package:ojembaa_mobile/utils/image_util.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColors.accent,
        body: Padding(
          padding: EdgeInsets.only(top: context.height(.05)),
          child: Stack(
            children: [
              Image.asset(
                ImageUtil.man_with_box,
              ),
              const WelcomeWidget()
            ],
          ),
        ),
      ),
    );
  }
}
