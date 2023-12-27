import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/request_courier/models/package_info_model.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/delivery_summary_widget.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/select_courier_widget.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';

class OrderDetails extends ConsumerWidget {
  final PackageInfoModel packageInfoModel;

  const OrderDetails(this.packageInfoModel, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          "Package summary",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width(.04), vertical: context.height(.02)),
        child: Column(
          children: [
            DeliverySummaryWidget(
              packageInfoModel: packageInfoModel,
              extraWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.height(.01)),
                  SizedBox(
                      height: context.height(.03),
                      child: const Divider(color: AppColors.primary)),
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Circle(
                              width: context.width(.065),
                              color: const Color(0xffE2CEA2),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: SvgPicture.asset("assets/icons/car.svg"),
                              )),
                          SizedBox(width: context.width(.02)),
                          Text(
                            "Medium Delivery",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: context.width(.035)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: context.height(.02)),
                  WhitePill(
                      color: const Color(0xffFFF0D2),
                      padding: EdgeInsets.symmetric(
                          horizontal: context.width(.03),
                          vertical: context.height(.008)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Circle(
                              width: context.width(.015),
                              color: AppColors.green,
                              child: const SizedBox.shrink()),
                          Text(
                            "   Delivered ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: context.width(.037)),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            SizedBox(height: context.height(.015)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: context.width(.03),
                  vertical: context.height(.015)),
              decoration: BoxDecoration(
                  color: const Color(0xffFEE4B1),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.height(.01)),
                      Text(
                        "Delivery fee",
                        style: TextStyle(fontSize: context.width(.033)),
                      ),
                      Text(
                        "₦15,000",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.red,
                            fontSize: context.width(.07)),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageUtil.pay_transfer),
                          Text(
                            "  Paid via bank transfer",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: context.width(.035)),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: context.width(.01)),
                            child: SvgPicture.asset(ImageUtil.eta),
                          ),
                          SizedBox(width: context.width(.015)),
                          Text(
                            "ETA\n1-3 days",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: context.width(.035)),
                          ),
                        ],
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.accent,
                            fontSize: context.width(.035)),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: context.width(.01)),
                            child: Circle(
                                width: context.width(.045),
                                color: AppColors.primary,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.5),
                                  child: SvgPicture.asset(
                                      "assets/icons/regular_delivery.svg"),
                                )),
                          ),
                          SizedBox(width: context.width(.015)),
                          Text(
                            "Regular\nDelivery",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: context.width(.035)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: context.height(.01)),
            SelectCourierWidget(
              onTap: null,
              courier: null,
              color: AppColors.accent,
              titleColor: AppColors.white,
              subtitle: Row(
                children: [
                  SvgPicture.asset(
                    ImageUtil.delivery_star2,
                  ),
                  Text(
                    " 4/5",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        fontSize: context.width(.035)),
                  ),
                ],
              ),
              trailing: Circle(
                  color: Colors.transparent,
                  borderColor: AppColors.primary,
                  width: context.width(.12),
                  child: const Icon(
                    Icons.phone,
                    color: AppColors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
