import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/request_courier/models/couriers_model.dart';
import 'package:ojembaa_mobile/features/request_courier/models/package_info_model.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/pick_courier_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/screens/delivery_confirmed.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/delivery_summary_widget.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/select_courier_widget.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/select_delivery_speed.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/select_payment_method.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/components/utility.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';
import 'package:ojembaa_mobile/utils/widgets/snackbar.dart';

class PaymentMethod extends ConsumerStatefulWidget {
  const PaymentMethod(
      {required this.packageInfoModel,
      required this.deliverySpeed,
      required this.couriersModel,
      required this.amount,
      required this.deliveryId,
      super.key});

  final DeliverySpeed deliverySpeed;
  final PackageInfoModel packageInfoModel;
  final CouriersModel couriersModel;
  final num amount;
  final String deliveryId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends ConsumerState<PaymentMethod> {
  PaymentType? paymentType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          "Select a payment method",
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
                extraWidget: Column(
                  children: [
                    SizedBox(
                        height: context.height(.08),
                        child: const Divider(color: AppColors.primary)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: context.height(.004)),
                              child: Circle(
                                  width: context.width(.05),
                                  color: AppColors.primary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SvgPicture.asset(
                                        "assets/icons/${widget.deliverySpeed.name.toLowerCase()}_delivery.svg"),
                                  )),
                            ),
                            SizedBox(width: context.width(.02)),
                            Text(
                              "${widget.deliverySpeed.name}\nDelivery",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: context.width(.033)),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: context.height(.004)),
                              child: SvgPicture.asset(
                                ImageUtil.estimated_price,
                                height: context.width(.04),
                              ),
                            ),
                            SizedBox(width: context.width(.02)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Estimated Cost",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: context.width(.033)),
                                ),
                                Text(
                                  Utility.currencyConverter(widget.amount),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.red,
                                      fontSize: context.width(.035)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: context.height(.004)),
                              child: SvgPicture.asset(ImageUtil.eta),
                            ),
                            SizedBox(width: context.width(.02)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ETA",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: context.width(.035)),
                                ),
                                Text(
                                  widget.deliverySpeed == DeliverySpeed.Express
                                      ? "1 day"
                                      : "1-3 days",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.accent,
                                      fontSize: context.width(.035)),
                                ),
                              ],
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
                trailing: Circle(
                    color: Colors.transparent,
                    borderColor: AppColors.primary,
                    width: context.width(.12),
                    child: const Icon(
                      Icons.phone,
                      color: AppColors.white,
                    )),
              ),
              SizedBox(height: context.height(.005)),
              GestureDetector(
                onTap: () {
                  setState(() {
                    paymentType = PaymentType.Cash;
                  });
                },
                child: SelectPaymentMethod(
                  paymentType: PaymentType.Cash,
                  selectedPaymentType: paymentType,
                  onChanged: (p0) {
                    setState(() {
                      paymentType = p0;
                    });
                  },
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       paymentType = PaymentType.Transfer;
              //     });
              //   },
              //   child: SelectPaymentMethod(
              //     paymentType: PaymentType.Transfer,
              //     selectedPaymentType: paymentType,
              //     onChanged: (p0) {
              //       setState(() {
              //         paymentType = p0;
              //       });
              //     },
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       paymentType = PaymentType.Card;
              //     });
              //   },
              //   child: SelectPaymentMethod(
              //     paymentType: PaymentType.Card,
              //     selectedPaymentType: paymentType,
              //     onChanged: (p0) {
              //       setState(() {
              //         paymentType = p0;
              //       });
              //     },
              //   ),
              // ),
              SizedBox(height: context.height(.01)),
              Consumer(builder: (context, ref, child) {
                final reader = ref.read(pickCourierProvider.notifier);
                final data = ref.watch(pickCourierProvider);
                return CustomContinueButton(
                  onPressed: () {
                    if (paymentType == null) {
                      CustomSnackbar.showErrorSnackBar(context,
                          message: "Please select a payment method");
                      return;
                    }
                    reader.pickCourier(
                      deliveryId: widget.deliveryId,
                      courierId: widget.couriersModel.id!,
                      onSuccess: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DeliveryConfirmed()));
                      },
                      onError: (p0) => CustomSnackbar.showErrorSnackBar(context,
                          message: p0),
                    );
                  },
                  isActive: !data.isLoading,
                  sidePadding: 0,
                  title: "Confirm",
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
