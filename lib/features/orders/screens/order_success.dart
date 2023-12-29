import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';

class OrderSuccess extends ConsumerWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width(.06), vertical: context.width(.3)),
        child: Column(
          children: [
            SvgPicture.asset(ImageUtil.delivery_successful),
            SizedBox(height: context.width(.03)),
            Text(
              "Delivery Successful🎉",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: context.width(.045)),
            ),
            SizedBox(height: context.width(.03)),
            Text(
              "Your package has been delivered successful",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: context.width(.035), color: AppColors.accent),
            ),
            SizedBox(height: context.width(.2)),
            Text(
              "Kindly rate our delivery service",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: context.width(.038), color: AppColors.accent),
            ),
            CustomContinueButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName("/mainPage"));
              },
              sidePadding: 0,
              textSize: context.width(.04),
              title: "Back to home",
            ),
          ],
        ),
      ),
    );
  }
}
