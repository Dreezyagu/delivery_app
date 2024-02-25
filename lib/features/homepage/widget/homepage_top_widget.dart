import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ojembaa_mobile/features/authentication/providers/signin_provider.dart';
import 'package:ojembaa_mobile/features/homepage/providers/get_location_provider.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';

class HomepageTopWidget extends StatefulWidget {
  const HomepageTopWidget({
    super.key,
  });

  @override
  State<HomepageTopWidget> createState() => _HomepageTopWidgetState();
}

class _HomepageTopWidgetState extends State<HomepageTopWidget> {
  LocationPermission? permission;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final data = ref.watch(getLocationProvider).data;
      return InkWell(
        onTap: () async {
          permission = await Geolocator.requestPermission();
          if (permission != LocationPermission.denied &&
              permission != LocationPermission.deniedForever) {
            ref.read(getLocationProvider.notifier).getCurrentLocation();
          }
        },
        child: Container(
          height: context.height(.3),
          padding: EdgeInsets.symmetric(horizontal: context.width(.06)),
          width: double.infinity,
          decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.height(.08)),
              Container(
                height: context.height(.06),
                width: context.width(.7),
                padding: EdgeInsets.symmetric(horizontal: context.width(.02)),
                decoration: BoxDecoration(
                    color: const Color(0xffFED485),
                    border: Border.all(color: AppColors.white),
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: context.width(.07),
                    ),
                    Expanded(
                        child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: context.width(.01)),
                      child: Text(
                        data != null
                            ? "${data.street}, ${data.administrativeArea}"
                            : "",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: context.width(.038)),
                      ),
                    )),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: context.width(.07),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.height(.025)),
              Consumer(
                  builder: (context, ref, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello ${ref.watch(signInProvider).data?.firstName}",
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: context.width(.07)),
                          ),
                          SizedBox(height: context.height(.005)),
                          WhitePill(
                            height: context.height(.045),
                            width: context.width(.5),
                            child: Row(
                              children: [
                                Circle(
                                  width: context.width(.06),
                                  child: Icon(
                                    Icons.phone,
                                    size: context.width(.035),
                                    color: AppColors.white,
                                  ),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: context.width(.02)),
                                  child: Text(
                                    "${ref.watch(signInProvider).data?.phone}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: context.width(.045)),
                                  ),
                                )),
                                SvgPicture.asset(
                                  ImageUtil.squigly_check,
                                  height: context.width(.06),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
            ],
          ),
        ),
      );
    });
  }
}
