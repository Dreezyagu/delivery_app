import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/orders/providers/rate_delivery_provider.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';

class OrderSuccess extends ConsumerStatefulWidget {
  const OrderSuccess(this.id, {super.key});

  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends ConsumerState<OrderSuccess> {
  double rating = 0;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width(.06)),
          child: Column(
            children: [
              SizedBox(height: context.width(.3)),
              SvgPicture.asset(ImageUtil.delivery_successful),
              SizedBox(height: context.width(.03)),
              Text(
                "Delivery Successful🎉",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: context.width(.045)),
              ),
              SizedBox(height: context.width(.03)),
              Text(
                "Your package has been delivered successful",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: context.width(.035), color: AppColors.accent),
              ),
              SizedBox(height: context.width(.2)),
              Text(
                "Kindly rate our delivery service",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: context.width(.038), color: AppColors.accent),
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (__, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {
                  setState(() {
                    this.rating = rating;
                  });
                },
              ),
              SizedBox(height: context.height(.06)),
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                    hintText: "Add a comment", prefixIcon: Icon(Icons.message)),
              ),
              SizedBox(height: context.height(.06)),
              Consumer(builder: (context, ref, _) {
                return CustomContinueButton(
                  onPressed: () {
                    ref.read(rateDeliveryProvider.notifier).rateDelivery(
                        deliveryId: widget.id,
                        feedback: controller.text,
                        rating: rating.ceil());
                    Navigator.popUntil(
                        context, ModalRoute.withName("/mainPage"));
                  },
                  sidePadding: 0,
                  textSize: context.width(.04),
                  title: "Back to home",
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
