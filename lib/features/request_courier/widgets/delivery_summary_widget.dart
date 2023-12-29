import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/orders/models/delivery_model.dart';
import 'package:ojembaa_mobile/features/request_courier/models/package_info_model.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';

class DeliverySummaryWidget extends StatelessWidget {
  final PackageInfoModel packageInfoModel;

  const DeliverySummaryWidget({
    super.key,
    this.extraWidget = const SizedBox.shrink(),
    required this.packageInfoModel,
  });

  final Widget extraWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: context.width(.04), vertical: context.height(.02)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffFEE4B1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    height: context.width(.15),
                    width: context.width(.15),
                    child: CachedNetworkImage(
                      imageUrl: packageInfoModel.photoUrl ?? "",
                      fit: BoxFit.fill,
                    )),
              ),
              SizedBox(
                width: context.width(.04),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      packageInfoModel.name ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: context.width(.045)),
                    ),
                    SizedBox(height: context.height(.005)),
                    Row(
                      children: [
                        Circle(
                            width: context.width(.065),
                            color: const Color(0xffE2CEA2),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(ImageUtil.bike),
                            )),
                        Text(
                          "  ${packageInfoModel.weight?.capitalize()} delivery",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: context.width(.033)),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: context.height(.02)),
          Text(
            "Pick up",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.accent.withOpacity(.69),
                fontSize: context.width(.037)),
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: context.width(.04),
                color: AppColors.accent,
              ),
              SizedBox(width: context.width(.02)),
              Expanded(
                child: Text(
                  "${packageInfoModel.pickupAddress ?? ""} (${packageInfoModel.pickupLandmark})",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                      fontSize: context.width(.037)),
                ),
              ),
            ],
          ),
          SizedBox(height: context.height(.04)),
          Text(
            "Drop off",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.accent.withOpacity(.69),
                fontSize: context.width(.037)),
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: context.width(.04),
                color: AppColors.accent,
              ),
              SizedBox(width: context.width(.02)),
              Expanded(
                child: Text(
                  "${packageInfoModel.deliveryAddress ?? ""} (${packageInfoModel.deliveryLandmark})",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                      fontSize: context.width(.037)),
                ),
              ),
            ],
          ),
          extraWidget
        ],
      ),
    );
  }
}

class DeliverySummaryWidget2 extends StatelessWidget {
  final DeliveryModel package;

  const DeliverySummaryWidget2({
    super.key,
    this.extraWidget = const SizedBox.shrink(),
    required this.package,
  });

  final Widget extraWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: context.width(.04), vertical: context.height(.02)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffFEE4B1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    height: context.width(.15),
                    width: context.width(.15),
                    child: CachedNetworkImage(
                      imageUrl: package.package?.photoUrls?.first ?? "",
                      fit: BoxFit.fill,
                    )),
              ),
              SizedBox(
                width: context.width(.04),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.package?.description ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: context.width(.045)),
                    ),
                    SizedBox(height: context.height(.005)),
                    Row(
                      children: [
                        Circle(
                            width: context.width(.065),
                            color: const Color(0xffE2CEA2),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(ImageUtil.bike),
                            )),
                        Text(
                          "  ${package.package?.weight?.toLowerCase().capitalize()} delivery",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: context.width(.033)),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: context.height(.02)),
          Text(
            "Pick up",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.accent.withOpacity(.69),
                fontSize: context.width(.037)),
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: context.width(.04),
                color: AppColors.accent,
              ),
              SizedBox(width: context.width(.02)),
              Expanded(
                child: Text(
                  package.pickupAddress ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                      fontSize: context.width(.037)),
                ),
              ),
            ],
          ),
          SizedBox(height: context.height(.04)),
          Text(
            "Drop off",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.accent.withOpacity(.69),
                fontSize: context.width(.037)),
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: context.width(.04),
                color: AppColors.accent,
              ),
              SizedBox(width: context.width(.02)),
              Expanded(
                child: Text(
                  package.deliveryAddress ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                      fontSize: context.width(.037)),
                ),
              ),
            ],
          ),
          extraWidget
        ],
      ),
    );
  }
}
