import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/request_courier/models/couriers_model.dart';
import 'package:ojembaa_mobile/features/request_courier/models/package_info_model.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/get_pricing_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/set_delivery_speed_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/screens/payment_method.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/delivery_summary_widget.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/select_delivery_speed.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/select_courier_widget.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';
import 'package:ojembaa_mobile/utils/widgets/snackbar.dart';

class PackageSummary extends ConsumerStatefulWidget {
  final PackageInfoModel packageInfoModel;
  final CouriersModel couriersModel;
  final String deliveryId;

  const PackageSummary({
    super.key,
    required this.packageInfoModel,
    required this.couriersModel,
    required this.deliveryId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PackageSummaryState();
}

class _PackageSummaryState extends ConsumerState<PackageSummary> {
  DeliverySpeed? groupValue;
  num? amount;
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
              DeliverySummaryWidget(
                packageInfoModel: widget.packageInfoModel,
              ),
              SizedBox(height: context.height(.02)),
              SelectCourierWidget(
                onTap: () {},
                courier: widget.couriersModel,
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
                trailing: const SizedBox.shrink(),
                // trailing: Circle(
                //     color: Colors.transparent,
                //     borderColor: AppColors.primary,
                //     width: context.width(.12),
                //     child: const Icon(
                //       Icons.phone,
                //       color: AppColors.white,
                //     )),
              ),
              SizedBox(height: context.height(.02)),
              Consumer(builder: (context, ref, child) {
                final data = ref.watch(getPricingProvider);

                if (data.isLoading) {
                  return const CircularProgressIndicator();
                }
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          groupValue = DeliverySpeed.Regular;
                          amount = data.data?.regular;
                        });
                      },
                      child: SelectDeliverySpeed(
                        deliverySpeed: DeliverySpeed.Regular,
                        selectedDeliverySpeed: groupValue,
                        amount: data.data?.regular,
                        onChanged: (p0) {
                          setState(() {
                            groupValue = p0;
                            amount = data.data?.regular;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: context.height(.015)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          groupValue = DeliverySpeed.Express;
                          amount = data.data?.express;
                        });
                      },
                      child: SelectDeliverySpeed(
                        deliverySpeed: DeliverySpeed.Express,
                        selectedDeliverySpeed: groupValue,
                        amount: data.data?.express,
                        onChanged: (p0) {
                          setState(() {
                            groupValue = p0;
                            amount = data.data?.express;
                          });
                        },
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: context.height(.015)),
              Consumer(builder: (context, ref, child) {
                final reader = ref.read(setDeliverySpeedProvider.notifier);
                final data = ref.watch(setDeliverySpeedProvider);

                return CustomContinueButton(
                  onPressed: () {
                    if (groupValue != null) {
                      reader.setDeliverySpeed(
                        deliveryId: widget.deliveryId,
                        mode: groupValue!.name.toLowerCase(),
                        onSuccess: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentMethod(
                                  deliverySpeed: groupValue!,
                                  packageInfoModel: widget.packageInfoModel,
                                  couriersModel: widget.couriersModel,
                                  amount: amount!,
                                  deliveryId: widget.deliveryId,
                                ),
                              ));
                        },
                        onError: (p0) => CustomSnackbar.showErrorSnackBar(
                            context,
                            message: p0),
                      );
                    } else {
                      CustomSnackbar.showErrorSnackBar(context,
                          message: "Please selct a delivery speed type");
                    }
                  },
                  isActive: !data.isLoading,
                  sidePadding: 0,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
