import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojembaa_mobile/features/homepage/widget/homepage_top_widget.dart';
import 'package:ojembaa_mobile/features/homepage/widget/homepage_whitepill.dart';
import 'package:ojembaa_mobile/features/request_courier/screens/deliver_package.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary_light,
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
                      "My Deliveries",
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
                SizedBox(height: context.height(.01)),
                Column(
                  children: [1, 2, 3]
                      .map((e) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: context.height(.007)),
                            child: WhitePill(
                                borderRadius: 20,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: context.height(.015),
                                    horizontal: context.width(.03)),
                                child: Row(
                                  children: [
                                    Circle(
                                        width: context.width(.1),
                                        color:
                                            AppColors.primary.withOpacity(.38),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              ImageUtil.delivery_box),
                                        )),
                                    SizedBox(width: context.width(.03)),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Samsung Plasma TV",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.accent,
                                              fontSize: context.width(.038)),
                                        ),
                                        Text(
                                          "#ID: 0208322773",
                                          style: TextStyle(
                                              color: const Color(0xff75868B),
                                              fontSize: context.width(.035)),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      "Delivered",
                                      style: TextStyle(
                                          color: AppColors.green,
                                          fontWeight: FontWeight.w500,
                                          fontSize: context.width(.035)),
                                    ),
                                    SizedBox(width: context.width(.02)),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: const Color(0xff0888B3)
                                          .withOpacity(.32),
                                      size: context.width(.045),
                                    )
                                  ],
                                )),
                          ))
                      .toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
