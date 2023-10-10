import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';

class SelectCourierWidget extends StatelessWidget {
  final Color? color, titleColor;
  final Widget? trailing, subtitle;
  final VoidCallback? onTap;

  const SelectCourierWidget(
      {super.key,
      this.color,
      this.trailing,
      this.subtitle,
      required this.onTap,
      this.titleColor});

  @override
  Widget build(BuildContext context) {
    return WhitePill(
      padding: EdgeInsets.symmetric(vertical: context.width(.0)),
      margin: EdgeInsets.symmetric(vertical: context.width(.017)),
      color: color ?? AppColors.primary_semi,
      child: ListTile(
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(ImageUtil.test_image),
        ),
        title: Text(
          "Ikenna Okwara",
          style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.w700,
              fontSize: context.width(.04)),
        ),
        subtitle: subtitle ??
            Row(
              children: [
                SvgPicture.asset(ImageUtil.delivery_star),
                Text(
                  " 4/5",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: context.width(.035)),
                ),
                Text(
                  "   10 Deliveries",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: context.width(.035)),
                ),
              ],
            ),
        trailing: trailing ??
            Text(
              " 4/5",
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: context.width(.038)),
            ),
      ),
    );
  }
}
