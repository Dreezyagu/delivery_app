import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojembaa_mobile/features/homepage/screens/homepage.dart';
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
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: const Color(0xffFEE1A7),
        items: [
          BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.width(.02)),
                  child: SvgPicture.asset(ImageUtil.home)),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.width(.02)),
                  child: SvgPicture.asset(ImageUtil.deliveries)),
              label: "Deliveries"),
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
      return Container();
    } else {
      return const Homepage();
    }
  }
}
