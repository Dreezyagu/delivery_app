import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_appbar.dart';

class PackageSummary extends ConsumerStatefulWidget {
  const PackageSummary({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PackageSummaryState();
}

class _PackageSummaryState extends ConsumerState<PackageSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          "Package summary",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width(.04), vertical: context.height(.02)),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: context.width(.04),
                  vertical: context.height(.02)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffFEE4B1),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        ImageUtil.test_image,
                        height: context.height(.07),
                      ),
                      SizedBox(
                        width: context.width(.04),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Electronic Wall Clock",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: context.width(.045)),
                            ),
                            Row(
                              children: [
                                Circle(
                                    width: context.width(.065),
                                    color: const Color(0xffE2CEA2),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: SvgPicture.asset(ImageUtil.bike),
                                    )),
                                Text(
                                  "  Light delivery",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: context.width(.033)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
