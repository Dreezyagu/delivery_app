import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/orders/providers/get_orders_provider.dart';
import 'package:ojembaa_mobile/features/orders/widgets/orders_list_widget.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.width(.04)),
        child: Column(
          children: [
            SizedBox(height: context.height(.01)),
            Text(
              "My Orders",
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: context.width(.045)),
            ),
            SizedBox(height: context.height(.02)),
            Consumer(
              builder: (context, ref, child) {
                final data = ref.watch(getOrdersProvider).data;
                if (ref.watch(getOrdersProvider).isLoading) {
                  return const CircularProgressIndicator();
                }
                if (data == null || data.isEmpty) {
                  return SvgPicture.asset(
                    ImageUtil.no_delivery,
                    height: context.height(.35),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) => OrdersListWidget(deliveryModel: data[index]),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
