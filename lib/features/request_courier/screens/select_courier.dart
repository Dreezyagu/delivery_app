import 'package:flutter/material.dart';
import 'package:ojembaa_mobile/utils/widgets/custom_appbar.dart';

class SelectCourier extends StatelessWidget {
  const SelectCourier({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Select a courier",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
