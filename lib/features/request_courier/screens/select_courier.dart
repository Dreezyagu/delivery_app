import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/request_courier/models/package_info_model.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/find_couriers_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/get_pricing_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/screens/package_summary.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/select_courier_widget.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_appbar.dart';

class SelectCourier extends ConsumerWidget {
  const SelectCourier(
      {super.key, required this.packageInfoModel, required this.deliveryId});

  final PackageInfoModel packageInfoModel;
  final String deliveryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          "Select a courier",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer(builder: (context, ref, child) {
        final data = ref.watch(findCouriersProvider);

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.width(.04), vertical: context.height(.02)),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(ImageUtil.nearby_courier),
                    Text(
                      "   Nearby couriers",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: context.width(.045)),
                    )
                  ],
                ),
                SizedBox(height: context.height(.015)),
                if (data.isLoading) const CircularProgressIndicator(),
                if (data.data != null && !data.isLoading)
                  Consumer(builder: (context, ref, child) {
                    final reader = ref.read(getPricingProvider.notifier);
                    return Column(
                      children: data.data!
                          .map((e) => SelectCourierWidget(
                                courier: e,
                                onTap: () {
                                  reader.getPricing(deliveryId: deliveryId);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PackageSummary(
                                          packageInfoModel: packageInfoModel,
                                          couriersModel: e,
                                          deliveryId: deliveryId,
                                        ),
                                      ));
                                },
                              ))
                          .toList(),
                    );
                  }),

                SizedBox(height: context.height(.03)),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.star_rounded,
                //       size: context.width(.07),
                //       color: AppColors.primary,
                //     ),
                //     Text(
                //       "   Top Rated Courier",
                //       style: TextStyle(
                //           fontWeight: FontWeight.w700,
                //           fontSize: context.width(.045)),
                //     )
                //   ],
                // ),
                // SizedBox(height: context.height(.015)),
                // Column(
                //   children: [1, 2, 3, 4]
                //       .map((e) => SelectCourierWidget(
                //             onTap: () {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                     builder: (context) =>
                //                         const PackageSummary(),
                //                   ));
                //             },
                //           ))
                //       .toList(),
                // ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
