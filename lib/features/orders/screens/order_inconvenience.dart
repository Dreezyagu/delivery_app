import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';

class OrderInconvenience extends ConsumerWidget {
  const OrderInconvenience({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width(.06), vertical: context.width(.3)),
        child: Column(
          children: [
            SvgPicture.asset(ImageUtil.delivery_inconvinience),
            SizedBox(height: context.width(.03)),
            Text(
              "Sorry for any inconvenience 😔",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: context.width(.045)),
            ),
            SizedBox(height: context.width(.03)),
            Text(
              "Our team will investigate the logistics of this issue. Please take a moment to share your feedback or comments.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: context.width(.035), color: AppColors.accent),
            ),
            SizedBox(height: context.width(.2)),
            TextFormField(
                decoration: InputDecoration(
                    hintText: "Add a comment",
                    prefix: SvgPicture.asset(ImageUtil.message))),
            SizedBox(height: context.width(.05)),
            CustomContinueButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName("/mainPage"));
              },
              sidePadding: 0,
              textSize: context.width(.04),
              title: "Report",
            ),
          ],
        ),
      ),
    );
  }
}
