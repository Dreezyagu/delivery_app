import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/request_courier/screens/package_summary.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/select_courier_widget.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_appbar.dart';

class SelectCourier extends ConsumerStatefulWidget {
  const SelectCourier({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectCourierState();
}

class _SelectCourierState extends ConsumerState<SelectCourier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          "Select a courier",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.width(.04), vertical: context.height(.02)),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(ImageUtil.nearby_courier),
                  Text(
                    "   Nearby courier",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: context.width(.045)),
                  )
                ],
              ),
              SizedBox(height: context.height(.015)),
              Column(
                children: [1, 2, 3, 4]
                    .map((e) => SelectCourierWidget(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PackageSummary(),
                                ));
                          },
                        ))
                    .toList(),
              ),
              SizedBox(height: context.height(.03)),
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: context.width(.07),
                    color: AppColors.primary,
                  ),
                  Text(
                    "   Top Rated Courier",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: context.width(.045)),
                  )
                ],
              ),
              SizedBox(height: context.height(.015)),
              Column(
                children: [1, 2, 3, 4]
                    .map((e) => SelectCourierWidget(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PackageSummary(),
                                ));
                          },
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
