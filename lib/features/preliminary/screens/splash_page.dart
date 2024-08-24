import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ojembaa_mobile/features/authentication/models/user_model.dart';
import 'package:ojembaa_mobile/features/authentication/providers/signin_provider.dart';
import 'package:ojembaa_mobile/features/authentication/screens/login_page.dart';
import 'package:ojembaa_mobile/features/homepage/providers/get_location_provider.dart';
import 'package:ojembaa_mobile/features/homepage/screens/nav_page.dart';
import 'package:ojembaa_mobile/features/orders/providers/get_orders_provider.dart';
import 'package:ojembaa_mobile/features/preliminary/screens/welcome_page.dart';
import 'package:ojembaa_mobile/features/request_courier/providers/get_categories_provider.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/helpers/storage/storage_helper.dart';
import 'package:ojembaa_mobile/utils/helpers/storage/storage_keys.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    checkToken();
    super.initState();
  }

  checkToken() async {
    final values = await Future.wait([
      StorageHelper.getString(StorageKeys.accessToken),
      StorageHelper.getString(StorageKeys.userModelKey),
      StorageHelper.getBoolean(StorageKeys.rememberMeKey, false)
    ]);

    UserModel? user;
    if (values[1] != null) {
      user = UserModel.fromJson(values[1] as String);
    }

    Future.delayed(
      const Duration(seconds: 3),
      () async {
        if (values.first != null && user != null && values.last == true) {
          Future.wait([
            ref.read(signInProvider.notifier).updateUserModel(user),
            ref.read(getOrdersProvider.notifier).getOrders(),
            ref.read(getCategoriesProvider.notifier).fetchCategories(),
          ]).then(
            (value) {
              if (value.every((element) => element == true)) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: "/mainPage"),
                      builder: (context) => const NavPage(),
                    ));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: "/loginPage"),
                      builder: (context) => const LoginPage(),
                    ));
              }
            },
          );

          final permission = await Geolocator.requestPermission();
          if (permission != LocationPermission.denied &&
              permission != LocationPermission.deniedForever) {
            ref.read(getLocationProvider.notifier).getCurrentLocation();
          }
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomePage(),
              ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                top: context.height(.1),
                child: SvgPicture.asset(
                  ImageUtil.big_icon,
                  height: context.height(.92),
                ),
              ),
            ],
          ),
          SvgPicture.asset(ImageUtil.icon_title)
        ],
      ),
    );
  }
}
