import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/orders/models/delivery_model.dart';
import 'package:ojembaa_mobile/features/orders/providers/get_orders_provider.dart';
import 'package:ojembaa_mobile/features/orders/providers/mark_complete_provider.dart';
import 'package:ojembaa_mobile/features/orders/screens/order_inconvenience.dart';
import 'package:ojembaa_mobile/features/orders/screens/order_success.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';
import 'package:ojembaa_mobile/utils/widgets/snackbar.dart';

class OrderConfirmation extends ConsumerStatefulWidget {
  final DeliveryModel deliveryModel;

  const OrderConfirmation({super.key, required this.deliveryModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderConfirmationState();
}

class _OrderConfirmationState extends ConsumerState<OrderConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width(.06), vertical: context.width(.3)),
        child: Column(
          children: [
            SvgPicture.asset(ImageUtil.delivered),
            SizedBox(height: context.width(.03)),
            Text(
              "Your package has been marked as delivered by our rider 📦 ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: context.width(.045)),
            ),
            SizedBox(height: context.width(.03)),
            Text(
              "Please click 'Confirm' to acknowledge receipt.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: context.width(.035), color: AppColors.accent),
            ),
            SizedBox(height: context.width(.2)),
            Consumer(builder: (context, ref, child) {
              final reader = ref.read(markCompleteProvider.notifier);

              return CustomContinueButton(
                onPressed: () {
                  reader.markComplete(
                    deliveryId: widget.deliveryModel.id!,
                    onSuccess: () {
                      ref.read(getOrdersProvider.notifier).getOrders();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderSuccess(),
                          ));
                    },
                    onError: (p0) =>
                        CustomSnackbar.showErrorSnackBar(context, message: p0),
                  );
                },
                sidePadding: 0,
                textSize: context.width(.04),
                isActive: !ref.watch(markCompleteProvider).isLoading,
                title: "Confirm",
              );
            }),
            Consumer(builder: (context, ref, child) {
              return CustomContinueButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderInconvenience(),
                      ));
                },
                sidePadding: 0,
                bgColor: const Color(0xffD7B97E).withOpacity(.35),
                textColor: AppColors.accent.withOpacity(.58),
                title: "Haven't received yet? Report",
                textSize: context.width(.04),
              );
            }),
          ],
        ),
      ),
    );
  }
}
