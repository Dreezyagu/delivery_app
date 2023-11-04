import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/orders/screens/order_details.dart';
import 'package:ojembaa_mobile/features/orders/widgets/orders_list_widget.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';

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
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderDetails(),
                          ));
                    },
                    child: const OrdersListWidget()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
