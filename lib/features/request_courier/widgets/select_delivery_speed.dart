import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/components/utility.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';

class SelectDeliverySpeed extends StatelessWidget {
  const SelectDeliverySpeed({
    super.key,
    required this.deliverySpeed,
    this.selectedDeliverySpeed,
    required this.onChanged,
    this.amount,
  });

  final DeliverySpeed deliverySpeed;
  final DeliverySpeed? selectedDeliverySpeed;
  final Function(DeliverySpeed?) onChanged;
  final num? amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: context.width(.03), vertical: context.height(.015)),
      decoration: BoxDecoration(
          color: AppColors.primary_semi,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Circle(
              width: context.width(.06),
              color: AppColors.primary,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                    "assets/icons/${deliverySpeed.name.toLowerCase()}_delivery.svg"),
              )),
          SizedBox(width: context.width(.02)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${deliverySpeed.name} Delivery",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: context.width(.043)),
                ),
                SizedBox(height: context.height(.02)),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(ImageUtil.estimated_price),
                            Text(
                              " Estimated Cost",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: context.width(.035)),
                            ),
                          ],
                        ),
                        Text(
                          Utility.currencyConverter(amount ?? 15000),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.red,
                              fontSize: context.width(.035)),
                        ),
                      ],
                    ),
                    SizedBox(width: context.width(.05)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(ImageUtil.eta),
                            Text(
                              " ETA",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: context.width(.035)),
                            ),
                          ],
                        ),
                        Text(
                          deliverySpeed == DeliverySpeed.Express
                              ? "1 day"
                              : "1-3 days",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.accent,
                              fontSize: context.width(.035)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Theme(
                      data: ThemeData.dark(),
                      child: Radio<DeliverySpeed>(
                        value: deliverySpeed,
                        groupValue: selectedDeliverySpeed,
                        onChanged: onChanged,
                        activeColor: AppColors.primary,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum DeliverySpeed { Regular, Express }
