import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ojembaa_mobile/features/authentication/providers/signin_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/models/autocomplete_model.dart';
import 'package:ojembaa_mobile/features/request_courier/models/package_info_model.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/auto_complete_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/find_couriers_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/package_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/upload_asset_provider.dart';
import 'package:ojembaa_mobile/features/request_courier/screens/select_courier.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/content_container.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/delivery_whitepill.dart';
import 'package:ojembaa_mobile/features/request_courier/widgets/image_picker_widget.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/components/number_formatter.dart';
import 'package:ojembaa_mobile/utils/components/utility.dart';
import 'package:ojembaa_mobile/utils/components/validators.dart';
import 'package:ojembaa_mobile/utils/widgets/circle.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_button.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_textfield.dart';
import 'package:ojembaa_mobile/utils/widgets/snackbar.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';

class DeliverPackage extends ConsumerStatefulWidget {
  const DeliverPackage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeliverPackageState();
}

class _DeliverPackageState extends ConsumerState<DeliverPackage> {
  final TextEditingController pickUpAddress = TextEditingController();
  final TextEditingController pickUpLandmarkController =
      TextEditingController();
  final TextEditingController dropOffAddress = TextEditingController();
  final TextEditingController dropOffLandmarkController =
      TextEditingController();
  final TextEditingController nameOfItem = TextEditingController();
  final TextEditingController worthOfItem = TextEditingController();
  final TextEditingController instructions = TextEditingController();
  final TextEditingController recipientName = TextEditingController();
  final TextEditingController recipientPhone = TextEditingController();

  File? _file;

  DeliveryType? deliveryType;

  Recipient? recipient;

  String? imageUrl;

  bool? checkedValue = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _recipientKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AutocompleteModel? pickUpLandmark;
  AutocompleteModel? dropOffLandmark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const CustomAppBar(
        title: Text(
          "Deliver a package",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width(.04)),
          child: Form(
            key: _formKey,
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
                      validator: Validators.notEmpty(),
                      keyboardType: TextInputType.name,
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
                        const String key = "AutocompletePickup";

                        final reader =
                            ref.read(autoCompleteProvider(key).notifier);
                        final watcher = ref.watch(autoCompleteProvider(key));

                        return Stack(
                          children: [
                            if (watcher.data != null &&
                                watcher.data!.isNotEmpty)
                              Card(
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Column(
                                  children: [
                                    SizedBox(height: context.height(.075)),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: watcher.data!.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            setState(() {
                                              pickUpLandmarkController.text =
                                                  watcher.data![index]
                                                          .description ??
                                                      "";
                                              pickUpLandmark =
                                                  watcher.data![index];

                                              reader.reset();
                                            });
                                          },
                                          tileColor: index % 2 == 0
                                              ? const Color(0xffFFEBC7)
                                                  .withOpacity(.08)
                                              : AppColors.white,
                                          title: Text(
                                            watcher.data![index].description ??
                                                "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            CustomTextFormField(
                              controller: pickUpLandmarkController,
                              borderColor: AppColors.white,
                              onChange: (value) {
                                reader.autoCompleteQuery(query: value);
                              },
                              hintText: "Landmark",
                              validator: Validators.notEmpty(),
                              keyboardType: TextInputType.name,
                              suffix: pickUpLandmarkController.text.isEmpty
                                  ? null
                                  : IconButton(
                                      onPressed: () {
                                        pickUpLandmark = null;
                                        pickUpLandmarkController.clear();
                                        reader.reset();
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: AppColors.hintColor,
                                      )),
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
                            ),
                          ],
                        );
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
                      hintText: "Drop off location",
                      validator: Validators.notEmpty(),
                      keyboardType: TextInputType.name,
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
                        const String key = "AutocompleteDropOff";
                        final reader =
                            ref.read(autoCompleteProvider(key).notifier);
                        final watcher = ref.watch(autoCompleteProvider(key));

                        return Stack(
                          children: [
                            if (watcher.data != null &&
                                watcher.data!.isNotEmpty)
                              Card(
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Column(
                                  children: [
                                    SizedBox(height: context.height(.075)),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: watcher.data!.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            setState(() {
                                              dropOffLandmarkController.text =
                                                  watcher.data![index]
                                                          .description ??
                                                      "";
                                              dropOffLandmark =
                                                  watcher.data![index];

                                              reader.reset();
                                            });
                                          },
                                          tileColor: index % 2 == 0
                                              ? const Color(0xffFFEBC7)
                                                  .withOpacity(.08)
                                              : AppColors.white,
                                          title: Text(
                                            watcher.data![index].description ??
                                                "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            CustomTextFormField(
                              controller: dropOffLandmarkController,
                              borderColor: AppColors.white,
                              onChange: (value) {
                                reader.autoCompleteQuery(query: value);
                              },
                              hintText: "Landmark",
                              validator: Validators.notEmpty(),
                              keyboardType: TextInputType.name,
                              suffix: dropOffLandmarkController.text.isEmpty
                                  ? null
                                  : IconButton(
                                      onPressed: () {
                                        dropOffLandmark = null;
                                        dropOffLandmarkController.clear();
                                        reader.reset();
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: AppColors.hintColor,
                                      )),
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
                            ),
                          ],
                        );
                      },
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
                        controller: nameOfItem,
                        borderColor: AppColors.white,
                        validator: Validators.notEmpty(),
                        keyboardType: TextInputType.name,
                        hintText: "Name of item(s)",
                        prefix: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.width(.015)),
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
                      SizedBox(height: context.height(.01)),
                      CustomTextFormField(
                        controller: worthOfItem,
                        borderColor: AppColors.white,
                        validator: Validators.notEmpty(),
                        keyboardType: TextInputType.number,
                        hintText: "Worth of item(s)",
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter()
                        ],
                        prefix: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.width(.015)),
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
                      Consumer(builder: (context, ref, child) {
                        final data = ref.watch(uploadAssetProvider);
                        final reader = ref.read(uploadAssetProvider.notifier);
                        return InkWell(
                          onTap: () {
                            if (Platform.isIOS) {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => ImagePickerWidget(
                                        onImageSelected: (XFile val) {
                                          _file = File(val.path);
                                          if (_file != null) {
                                            reader.uploadPicture(
                                                file: _file!,
                                                onSuccess: (String url) {
                                                  setState(() {
                                                    imageUrl = url;
                                                  });
                                                  CustomSnackbar
                                                      .showSuccessSnackBar(
                                                          _scaffoldKey
                                                              .currentContext!,
                                                          message:
                                                              "Upload successful");
                                                },
                                                onError: (p0) {
                                                  _file = null;
                                                  CustomSnackbar
                                                      .showErrorSnackBar(
                                                          _scaffoldKey
                                                              .currentContext!,
                                                          message: p0);
                                                });
                                          }
                                        },
                                        onCanceled: () =>
                                            Navigator.pop(context),
                                      ));
                            } else {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => ImagePickerWidget(
                                        onImageSelected: (XFile val) {
                                          _file = File(val.path);
                                          if (_file != null) {
                                            reader.uploadPicture(
                                                file: _file!,
                                                onSuccess: (String url) {
                                                  setState(() {
                                                    imageUrl = url;
                                                  });
                                                  CustomSnackbar
                                                      .showSuccessSnackBar(
                                                          _scaffoldKey
                                                              .currentContext!,
                                                          message:
                                                              "Upload successful");
                                                },
                                                onError: (p0) {
                                                  _file = null;
                                                  CustomSnackbar
                                                      .showErrorSnackBar(
                                                          _scaffoldKey
                                                              .currentContext!,
                                                          message: p0);
                                                });
                                          }
                                        },
                                        onCanceled: () =>
                                            Navigator.pop(context),
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
                                  imageUrl != null
                                      ? SizedBox(
                                          height: context.width(.15),
                                          // width: context.width(.2),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(_file!)),
                                        )
                                      : Circle(
                                          width: context.width(.08),
                                          color: AppColors.primary
                                              .withOpacity(.38),
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
                                    child: data.isLoading
                                        ? SizedBox(
                                            height: context.width(.06),
                                            width: context.width(.06),
                                            child:
                                                const CircularProgressIndicator(
                                              color: AppColors.white,
                                            ),
                                          )
                                        : Text(
                                            _file != null ? "Retake" : "Take",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: context.width(.037)),
                                          ),
                                  )
                                ],
                              )),
                        );
                      }),
                      SizedBox(height: context.height(.02)),
                      CustomTextFormField(
                        controller: instructions,
                        borderRadius: 15,
                        borderColor: AppColors.white,
                        keyboardType: TextInputType.name,
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width(.03),
                          vertical: context.width(.035),
                        ),
                        maxLines: 4,
                        hintText:
                            "Specific Instruction to the courier (Optional)",
                      ),
                      SizedBox(height: context.width(.02)),
                      Row(children: [
                        Checkbox(
                            value: checkedValue,
                            checkColor: AppColors.white,
                            activeColor: AppColors.primary,
                            onChanged: (bool? value) {
                              setState(() {
                                checkedValue = value;
                              });
                            }),
                        Text(
                          "Fragile Item ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.accent,
                            fontSize: context.width(.035),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
                SizedBox(height: context.height(.02)),
                ContentContainer(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recipients",
                      style: TextStyle(fontSize: context.width(.04)),
                    ),
                    SizedBox(height: context.height(.015)),
                    Row(
                      children: [
                        DeliveryWhitepill(
                          title: "Me          ",
                          fontSize: context.width(.035),
                          selected: recipient == Recipient.me,
                          onTap: () {
                            setState(() {
                              recipient = Recipient.me;
                            });
                          },
                          icon: ImageUtil.profile,
                        ),
                        SizedBox(width: context.width(.05)),
                        DeliveryWhitepill(
                          title: "Third party",
                          fontSize: context.width(.035),
                          selected: recipient == Recipient.thirdParty,
                          onTap: () {
                            setState(() {
                              recipient = Recipient.thirdParty;
                            });
                          },
                          icon: ImageUtil.person,
                        ),
                      ],
                    ),
                    if (recipient == Recipient.thirdParty)
                      Form(
                        key: _recipientKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.height(.02)),
                              child: const Divider(),
                            ),
                            CustomTextFormField(
                              controller: recipientName,
                              borderColor: AppColors.white,
                              hintText: "Enter Recipient name",
                              validator: Validators.notEmpty(),
                              keyboardType: TextInputType.name,
                              prefix: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: context.width(.015)),
                                child: Circle(
                                  width: 0,
                                  color: AppColors.primary.withOpacity(.38),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      ImageUtil.person,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: context.height(.02)),
                            CustomTextFormField(
                              controller: recipientPhone,
                              borderColor: AppColors.white,
                              hintText: "Enter Recipient phone number",
                              validator: Validators.notEmpty(),
                              keyboardType: TextInputType.phone,
                              prefix: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: context.width(.015)),
                                child: Circle(
                                  width: 0,
                                  color: AppColors.primary.withOpacity(.38),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      ImageUtil.phone_number,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                )),
                SizedBox(height: context.height(.03)),
                Consumer(builder: (context, ref, child) {
                  final data = ref.watch(packageProvider);
                  final reader = ref.read(packageProvider.notifier);
                  final profileData = ref.watch(signInProvider).data;

                  return CustomContinueButton(
                    isActive: !data.isLoading,
                    onPressed: () {
                      if (deliveryType == null) {
                        CustomSnackbar.showErrorSnackBar(context,
                            message: "Please select a delivery type");
                        return;
                      }
                      if (pickUpLandmark == null || dropOffLandmark == null) {
                        CustomSnackbar.showErrorSnackBar(context,
                            message: "Please select a verifiable landmark");
                        return;
                      }
                      if (_file == null) {
                        CustomSnackbar.showErrorSnackBar(context,
                            message: "Please upload a picture of item(s)");
                        return;
                      }
                      if (recipient == null) {
                        CustomSnackbar.showErrorSnackBar(context,
                            message: "Please select a recipient");
                        return;
                      }
                      if (imageUrl == null) {
                        CustomSnackbar.showErrorSnackBar(context,
                            message:
                                "Your image upload was unsuccessful, please try again.");
                        return;
                      }

                      if (_formKey.currentState?.validate() == true) {
                        if (recipient == Recipient.thirdParty &&
                            _recipientKey.currentState?.validate() == false) {
                          CustomSnackbar.showErrorSnackBar(context,
                              message: "Please complete the recipient details");
                          return;
                        }
                        final PackageInfoModel packageInfo = PackageInfoModel(
                            nameOfItem.text.trim(),
                            instructions.text.trim(),
                            recipient == Recipient.thirdParty
                                ? recipientName.text.trim()
                                : "${profileData?.firstName} ${profileData?.lastName}",
                            recipient == Recipient.thirdParty
                                ? recipientPhone.text.trim()
                                : "${profileData?.phone}",
                            Utility.convertToRealNumber(
                                worthOfItem.text.trim()),
                            imageUrl,
                            checkedValue,
                            deliveryType?.name,
                            pickUpAddress.text.trim(),
                            dropOffAddress.text.trim(),
                            pickUpLandmarkController.text.trim(),
                            dropOffLandmarkController.text.trim());
                        reader.createPackage(
                          payload: {
                            "name": packageInfo.name,
                            "instructions": packageInfo.instructions,
                            "receiverName": packageInfo.receiverName,
                            "receiverPhone": packageInfo.receiverPhone,
                            "photoUrls": [packageInfo.photoUrl],
                            "worth": packageInfo.worth,
                            "fragile": packageInfo.fragile,
                            "weight": packageInfo.weight!.toUpperCase(),
                          },
                          onSuccess: (String packageID) {
                            reader.createDelivery(
                              payload: {
                                "pickupAddress": packageInfo.pickupAddress,
                                "deliveryAddress": packageInfo.deliveryAddress,
                                "packageId": packageID,
                                "pickupLandmark": packageInfo.pickupLandmark,
                                "deliveryLandmark": packageInfo.deliveryLandmark
                              },
                              pickupId: pickUpLandmark!.placeId!,
                              dropoffId: dropOffLandmark!.placeId!,
                              onSuccess: (String deliveryId) {
                                ref
                                    .read(findCouriersProvider.notifier)
                                    .findCouriers(deliveryId: deliveryId);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SelectCourier(
                                        packageInfoModel: packageInfo,
                                        deliveryId: deliveryId,
                                      ),
                                    ));
                              },
                              onError: (p0) {
                                CustomSnackbar.showErrorSnackBar(context,
                                    message: p0);
                              },
                            );
                          },
                          onError: (p0) {
                            CustomSnackbar.showErrorSnackBar(context,
                                message: p0);
                          },
                        );
                      }
                    },
                    sidePadding: 0,
                  );
                }),
                SizedBox(height: context.height(.03)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
