import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';

class SelectPaymentMethod extends StatelessWidget {
  const SelectPaymentMethod({
    super.key,
    required this.paymentType,
    this.selectedPaymentType,
    required this.onChanged,
  });

  final PaymentType paymentType;
  final PaymentType? selectedPaymentType;
  final Function(PaymentType?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: context.height(.008)),
      padding: EdgeInsets.symmetric(
          horizontal: context.width(.03), vertical: context.height(.018)),
      decoration: BoxDecoration(
          color: AppColors.primary_semi,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            paymentType == PaymentType.Cash
                ? ImageUtil.pay_cash
                : paymentType == PaymentType.Transfer
                    ? ImageUtil.pay_transfer
                    : ImageUtil.pay_card,
            height: PaymentType.Cash == paymentType
                ? context.width(.07)
                : context.width(.05),
          ),
          SizedBox(width: context.width(.04)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paymentType == PaymentType.Cash
                      ? "Pay with cash"
                      : paymentType == PaymentType.Transfer
                          ? "Pay via bank transfer"
                          : "Pay with Card",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.accent,
                      fontSize: context.width(.043)),
                ),
                Text(
                  paymentType == PaymentType.Cash
                      ? "Pay on delivery to the dispatch rider. "
                      : paymentType == PaymentType.Transfer
                          ? "Pay through bank transfer "
                          : "Pay using your debit card.",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.accent,
                      fontSize: context.width(.035)),
                ),
              ],
            ),
          ),
          Theme(
            data: ThemeData.dark(),
            child: Radio<PaymentType>(
              value: paymentType,
              groupValue: selectedPaymentType,
              onChanged: onChanged,
              activeColor: AppColors.primary,
            ),
          )
        ],
      ),
    );
  }
}

enum PaymentType { Cash, Card, Transfer }
