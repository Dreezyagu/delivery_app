import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/orders/models/delivery_model.dart';
import 'package:ojembaa_mobile/features/orders/screens/order_details.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';

class OrdersListWidget extends StatelessWidget {
  const OrdersListWidget({
    super.key,
    required this.deliveryModel,
  });

  final DeliveryModel deliveryModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetails(
                deliveryModel: deliveryModel,
              ),
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.height(.007)),
        child: WhitePill(
            borderRadius: 20,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                vertical: context.height(.015), horizontal: context.width(.02)),
            child: Row(
              children: [
                Circle(
                    width: context.width(.08),
                    color: AppColors.primary.withOpacity(.38),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(ImageUtil.delivery_box),
                    )),
                SizedBox(width: context.width(.03)),
                Expanded(
                  child: Text(
                    deliveryModel.package?.description ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                        fontSize: context.width(.038)),
                  ),
                ),
                Text(
                  (deliveryModel.status ?? "").toLowerCase().capitalize(),
                  style: TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: context.width(.035)),
                ),
                SizedBox(width: context.width(.02)),
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xff0888B3).withOpacity(.32),
                  size: context.width(.045),
                )
              ],
            )),
      ),
    );
  }
}
