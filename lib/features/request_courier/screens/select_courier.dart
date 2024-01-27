import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/request_courier/models/package_info_model.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/find_couriers_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/get_pricing_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/screens/package_summary.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/select_courier_widget.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';

class SelectCourier extends ConsumerStatefulWidget {
  const SelectCourier(
      {super.key, required this.packageInfoModel, required this.deliveryId});

  final PackageInfoModel packageInfoModel;
  final String deliveryId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectCourierState();
}

class _SelectCourierState extends ConsumerState<SelectCourier> {
  double slideValue = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          "Select a courier",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer(builder: (context, ref, child) {
        final data = ref.watch(findCouriersProvider);
        final reader = ref.watch(findCouriersProvider.notifier);

        final pricingReader = ref.read(getPricingProvider.notifier);

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.width(.04), vertical: context.height(.02)),
            child: Column(
              children: [
                SizedBox(height: context.width(.015)),
                if (data.isLoading)
                  Center(
                      child: Column(
                    children: [
                      SizedBox(height: context.width(.5)),
                      const CircularProgressIndicator(),
                    ],
                  )),
                if ((data.data == null || data.data!.isEmpty) &&
                    !data.isLoading)
                  Column(
                    children: [
                      SizedBox(height: context.width(.1)),
                      SvgPicture.asset(
                        ImageUtil.no_couriers,
                        width: context.width(.15),
                      ),
                      SizedBox(height: context.width(.08)),
                      Text(
                        "Apologies, there is no courier close by",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent,
                          fontSize: context.width(.04),
                        ),
                      ),
                      SizedBox(height: context.width(.03)),
                      Text(
                        "Expand your radius to see more couriers",
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: context.width(.04),
                        ),
                      ),
                      SizedBox(height: context.width(.1)),
                      SliderTheme(
                        data: const SliderThemeData(
                            activeTickMarkColor: Colors.transparent,
                            activeTrackColor: AppColors.accent,
                            inactiveTrackColor: AppColors.white,
                            thumbColor: AppColors.primary,
                            inactiveTickMarkColor: Colors.transparent),
                        child: Slider(
                          value: slideValue,
                          onChanged: (value) {
                            setState(() {
                              slideValue = value;
                            });
                          },
                          label: "${slideValue.round()}km",
                          min: 0,
                          max: 50,
                          divisions: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ["0km", "50km"]
                              .map((e) => Text(
                                    e,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.accent,
                                      fontSize: context.width(.04),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      CustomContinueButton(
                        onPressed: () {
                          reader.findCouriers(
                              deliveryId: widget.deliveryId,
                              radius: slideValue.toInt());
                        },
                        title: "Search",
                        topPadding: context.width(.1),
                      )
                    ],
                  ),
                if (data.data != null && !data.isLoading)
                  Column(
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
                      Column(
                        children: data.data!
                            .map((e) => SelectCourierWidget(
                                  courier: e,
                                  onTap: () {
                                    pricingReader.getPricing(
                                        deliveryId: widget.deliveryId);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PackageSummary(
                                            packageInfoModel:
                                                widget.packageInfoModel,
                                            couriersModel: e,
                                            deliveryId: widget.deliveryId,
                                          ),
                                        ));
                                  },
                                ))
                            .toList(),
                      ),
                    ],
                  ),

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
