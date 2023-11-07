import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/auto_complete_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/screens/select_courier.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/content_container.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/delivery_whitepill.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/image_picker_widget.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_dropdown.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_textfield.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';

class DeliverPackage extends ConsumerStatefulWidget {
  const DeliverPackage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeliverPackageState();
}

class _DeliverPackageState extends ConsumerState<DeliverPackage> {
  final TextEditingController pickUpAddress = TextEditingController();
  final TextEditingController pickUpLandmark = TextEditingController();
  final TextEditingController dropOffAddress = TextEditingController();
  final TextEditingController dropOffLandmark = TextEditingController();
  final TextEditingController nameOfItem = TextEditingController();

  File? _file;

  DeliveryType? deliveryType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          "Deliver a package",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width(.04)),
          child: Column(
            children: [
              ContentContainer(
                padding: EdgeInsets.symmetric(
                    horizontal: context.width(.02),
                    vertical: context.height(.015)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select delivery type",
                      style: TextStyle(fontSize: context.width(.04)),
                    ),
                    SizedBox(height: context.height(.015)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DeliveryWhitepill(
                          title: "Light\nDelivery",
                          selected: deliveryType == DeliveryType.light,
                          onTap: () {
                            setState(() {
                              deliveryType = DeliveryType.light;
                            });
                          },
                          icon: ImageUtil.bike,
                        ),
                        DeliveryWhitepill(
                          title: "Medium\nDelivery",
                          selected: deliveryType == DeliveryType.medium,
                          onTap: () {
                            setState(() {
                              deliveryType = DeliveryType.medium;
                            });
                          },
                          icon: ImageUtil.car,
                        ),
                        DeliveryWhitepill(
                          title: "Heavy\nDelivery",
                          selected: deliveryType == DeliveryType.heavy,
                          onTap: () {
                            setState(() {
                              deliveryType = DeliveryType.heavy;
                            });
                          },
                          icon: ImageUtil.delivery_truck,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: context.height(.02)),
              ContentContainer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pick up address:",
                    style: TextStyle(fontSize: context.width(.04)),
                  ),
                  SizedBox(height: context.height(.01)),
                  CustomTextFormField(
                    controller: pickUpAddress,
                    borderColor: AppColors.white,
                    hintText: "Pick up location",
                    prefix: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.width(.015)),
                      child: Circle(
                        width: 0,
                        color: AppColors.primary.withOpacity(.38),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            ImageUtil.pickup,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.height(.01)),
                  Consumer(
                    builder: (context, ref, child) {
                      final reader = ref.read(autoCompleteProvider.notifier);
                      return CustomTextFormField(
                        controller: pickUpLandmark,
                        borderColor: AppColors.white,
                        onChange: (value) {
                          reader.autoCompleteQuery(query: value);
                        },
                        hintText: "Landmark",
                        prefix: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.width(.015)),
                          child: Circle(
                            width: 0,
                            color: AppColors.primary.withOpacity(.38),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                ImageUtil.landmark,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final watcher = ref.watch(autoCompleteProvider);

                      if (watcher.data != null) {
                        if (watcher.data!.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        if (watcher.data!.isNotEmpty) {
                          return Column(
                            children: [
                              SizedBox(
                                height: context.height(.02),
                                child: const Divider(),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: watcher.data!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        watcher.data![index].description ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Divider(),
                                    ],
                                  );
                                },
                              )
                            ],
                          );
                        }
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  SizedBox(height: context.height(.02)),
                  Text(
                    "Drop off address:",
                    style: TextStyle(fontSize: context.width(.04)),
                  ),
                  SizedBox(height: context.height(.01)),
                  CustomTextFormField(
                    controller: dropOffAddress,
                    borderColor: AppColors.white,
                    hintText: "Pick up location",
                    prefix: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.width(.015)),
                      child: Circle(
                        width: 0,
                        color: AppColors.primary.withOpacity(.38),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            ImageUtil.pickup,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.height(.01)),
                  CustomTextFormField(
                    controller: dropOffLandmark,
                    borderColor: AppColors.white,
                    hintText: "Landmark",
                    prefix: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.width(.015)),
                      child: Circle(
                        width: 0,
                        color: AppColors.primary.withOpacity(.38),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            ImageUtil.landmark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
              SizedBox(height: context.height(.02)),
              ContentContainer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Package details",
                    style: TextStyle(fontSize: context.width(.04)),
                  ),
                  SizedBox(height: context.height(.01)),
                  CustomTextFormField(
                    controller: pickUpAddress,
                    borderColor: AppColors.white,
                    hintText: "Name of item(s)",
                    prefix: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.width(.015)),
                      child: Circle(
                        width: context.width(.0),
                        color: AppColors.primary.withOpacity(.38),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            ImageUtil.pickup,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.height(.015)),
                  CustomDropDownFormField(
                    items: const [],
                    value: 1,
                    hintText: "Worth of item(s)",
                    onChanged: (value) {},
                  ),
                  SizedBox(height: context.height(.015)),
                  InkWell(
                    onTap: () {
                      if (Platform.isIOS) {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => ImagePickerWidget(
                                  onImageSelected: (XFile val) {
                                    setState(() {
                                      _file = File(val.path);
                                    });
                                  },
                                  onCanceled: () => Navigator.pop(context),
                                ));
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => ImagePickerWidget(
                                  onImageSelected: (XFile val) {
                                    setState(() {
                                      _file = File(val.path);
                                    });
                                  },
                                  onCanceled: () => Navigator.pop(context),
                                ));
                      }
                    },
                    child: WhitePill(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                                vertical: context.height(.01),
                                horizontal: context.width(.02)) +
                            EdgeInsets.only(left: context.width(.02)),
                        child: Row(
                          children: [
                            _file != null
                                ? SizedBox(
                                    height: context.width(.15),
                                    // width: context.width(.2),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(_file!)),
                                  )
                                : Circle(
                                    width: context.width(.08),
                                    color: AppColors.primary.withOpacity(.38),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        ImageUtil.camera,
                                      ),
                                    ),
                                  ),
                            SizedBox(width: context.width(.02)),
                            Expanded(
                              child: Text(
                                "Take a picture of your item(s)",
                                style: TextStyle(
                                    fontSize: context.width(.035),
                                    color: AppColors.hintColor),
                              ),
                            ),
                            WhitePill(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.width(.04),
                                  vertical: context.height(.01)),
                              color: AppColors.primary,
                              child: Text(
                                _file != null ? "Retake" : "Take",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: context.width(.037)),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              )),
              SizedBox(height: context.height(.03)),
              CustomContinueButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectCourier(),
                      ));
                },
                sidePadding: 0,
              ),
              SizedBox(height: context.height(.03)),
            ],
          ),
        ),
      ),
    );
  }
}
