import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/request_courier/screens/payment_method.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/delivery_summary_widget.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/select_delivery_speed.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/select_courier_widget.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';

class PackageSummary extends ConsumerStatefulWidget {
  const PackageSummary({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PackageSummaryState();
}

class _PackageSummaryState extends ConsumerState<PackageSummary> {
  DeliverySpeed? groupValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          "Package summary",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.width(.04), vertical: context.height(.02)),
          child: Column(
            children: [
              const DeliverySummaryWidget(),
              SizedBox(height: context.height(.02)),
              SelectCourierWidget(
                onTap: null,
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
              SizedBox(height: context.height(.02)),
              GestureDetector(
                onTap: () {
                  setState(() {
                    groupValue = DeliverySpeed.Regular;
                  });
                },
                child: SelectDeliverySpeed(
                  deliverySpeed: DeliverySpeed.Regular,
                  selectedDeliverySpeed: groupValue,
                  onChanged: (p0) {
                    setState(() {
                      groupValue = p0;
                    });
                  },
                ),
              ),
              SizedBox(height: context.height(.015)),
              GestureDetector(
                onTap: () {
                  setState(() {
                    groupValue = DeliverySpeed.Express;
                  });
                },
                child: SelectDeliverySpeed(
                  deliverySpeed: DeliverySpeed.Express,
                  selectedDeliverySpeed: groupValue,
                  onChanged: (p0) {
                    setState(() {
                      groupValue = p0;
                    });
                  },
                ),
              ),
              SizedBox(height: context.height(.015)),
              CustomContinueButton2(
                onPressed: () {
                  if (groupValue != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentMethod(deliverySpeed: groupValue!),
                        ));
                  }
                },
                sidePadding: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

