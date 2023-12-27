import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';

class DeliveryConfirmed extends StatelessWidget {
  const DeliveryConfirmed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: context.height(.3)),
              SvgPicture.asset(ImageUtil.delivery_confirmed),
              SizedBox(height: context.height(.02)),
              Text(
                "Your request is all set for\npick-up and delivery 📦🚚",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: context.width(.06)),
              ),
              SizedBox(height: context.height(.02)),
              Text(
                "Our rider will pick up your order and\ndelivery it to your location.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w400,
                    fontSize: context.width(.045)),
              ),
              const Spacer(),
              CustomContinueButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName("/mainPage"));
                },
                title: "Back to home",
              ),
              SizedBox(height: context.height(.05))
            ],
          ),
        ),
      ),
    );
  }
}
