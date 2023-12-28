import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/homepage/widget/homepage_top_widget.dart';
import 'package:ojembaa_mobile/features/homepage/widget/homepage_whitepill.dart';
import 'package:ojembaa_mobile/features/orders/providers/get_orders_provider.dart';
import 'package:ojembaa_mobile/features/orders/widgets/orders_list_widget.dart';
import 'package:ojembaa_mobile/features/request_courier/screens/deliver_package.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomepageTopWidget(),
          SizedBox(height: context.height(.03)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width(.05)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomepageWhitepill(
                      title: "Deliver a package",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DeliverPackage(),
                            ));
                      },
                      icon: ImageUtil.delivery_box,
                    ),
                    HomepageWhitepill(
                      title: "Refer a friend",
                      onTap: () {},
                      icon: ImageUtil.person,
                    ),
                  ],
                ),
                SizedBox(height: context.height(.035)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Orders",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent,
                          fontSize: context.width(.06)),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                          color: AppColors.accent,
                          fontSize: context.width(.04)),
                    ),
                  ],
                ),
                SizedBox(height: context.width(.03)),

                Consumer(
                  builder: (context, ref, child) {
                    final data = ref.watch(getOrdersProvider).data;
                    if (ref.watch(getOrdersProvider).isLoading) {
                      return Column(
                        children: [
                          SizedBox(
                            height: context.width(.2),
                          ),
                          const CircularProgressIndicator(),
                        ],
                      );
                    }

                    if (data == null || data.isEmpty) {
                      return SvgPicture.asset(
                        ImageUtil.no_delivery,
                        height: context.height(.35),
                      );
                    }
                    if (data.length > 5) {
                      data.sublist(0, 5);
                    }

                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) =>
                          OrdersListWidget(deliveryModel: data[index]),
                    );
                  },
                )

                // Column(
                //   children:
                //       [1, 2, 3].map((e) => const OrdersListWidget()).toList(),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
