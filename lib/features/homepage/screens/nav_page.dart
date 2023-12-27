import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojembaa_mobile/features/homepage/screens/homepage.dart';
import 'package:ojembaa_mobile/features/orders/screens/orders_page.dart';
import 'package:ojembaa_mobile/features/profile/screens/profile_page.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          PopScope(  
            canPop: false,
           child: getBody()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: const Color(0xffFEE1A7),
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.black,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        selectedIconTheme: const IconThemeData(color: AppColors.primary),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.width(.02)),
                  child: SvgPicture.asset(
                    ImageUtil.home,
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 0
                            ? AppColors.primary
                            : AppColors.default_icon,
                        BlendMode.srcIn),
                  )),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.width(.02)),
                  child: SvgPicture.asset(ImageUtil.deliveries,
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 1
                              ? AppColors.primary
                              : AppColors.default_icon,
                          BlendMode.srcIn))),
              label: "My Orders"),
          BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.width(.02)),
                  child: SvgPicture.asset(ImageUtil.notification,
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 2
                              ? AppColors.primary
                              : AppColors.default_icon,
                          BlendMode.srcIn))),
              label: "Notification"),
          BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.width(.02)),
                  child: SvgPicture.asset(ImageUtil.profile)),
              label: "Profile"),
        ],
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return const Homepage();
    } else if (selectedIndex == 1) {
      return const OrdersPage();
    } else if (selectedIndex == 3) {
      return const ProfilePage();
    } else {
      return const Homepage();
    }
  }
}
