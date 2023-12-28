import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/orders/models/delivery_model.dart';
import 'package:ojembaa_mobile/features/request_courier/models/couriers_model.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';
import 'package:shimmer/shimmer.dart';

class SelectCourierWidget extends StatelessWidget {
  final Color? color, titleColor;
  final Widget? trailing, subtitle;
  final VoidCallback? onTap;
  final CouriersModel? courier;

  const SelectCourierWidget(
      {super.key,
      this.color,
      this.trailing,
      this.subtitle,
      required this.onTap,
      this.titleColor,
      required this.courier});

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
          child: SizedBox(
              height: context.width(.15),
              width: context.width(.15),
              child: CachedNetworkImage(
                imageUrl: courier!.user_profilePhoto!,
                fit: BoxFit.fill,
              )),
        ),
        title: Text(
          "${courier?.user_firstName ?? ""} ${courier?.user_lastName}",
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
                  " 4.5",
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
              "${double.parse(courier!.distance!).toStringAsFixed(1)}km",
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: context.width(.038)),
            ),
      ),
    );
  }
}

class SelectCourierWidget2 extends StatelessWidget {
  final Color? color, titleColor;
  final Widget? trailing, subtitle;
  final VoidCallback? onTap;
  final Courier? courier;

  const SelectCourierWidget2(
      {super.key,
      this.color,
      this.trailing,
      this.subtitle,
      required this.onTap,
      this.titleColor,
      required this.courier});

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
            child: SizedBox(
                height: context.width(.15),
                width: context.width(.15),
                child: CachedNetworkImage(
                  imageUrl: courier!.profilePhoto ?? "",
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppColors.hintColor,
                    highlightColor: AppColors.hintColor,
                    child: const SizedBox.shrink(),
                  ),
                  errorWidget: (context, url, error) => const SizedBox(
                    child: ColoredBox(color: AppColors.hintColor),
                  ),
                  fit: BoxFit.fill,
                )),
          ),
          title: Text(
            "${courier?.firstName ?? ""} ${courier?.lastName}",
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
                    " 4.5",
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
          trailing: trailing),
    );
  }
}
