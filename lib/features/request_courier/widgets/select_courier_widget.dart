import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_mobile/features/request_courier/screens/package_summary.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';
import 'package:ojembaa_mobile/utils/components/image_util.dart';
import 'package:ojembaa_mobile/utils/widgets/white_pill.dart';

class SelectCourierWidget extends StatelessWidget {
  const SelectCourierWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WhitePill(
      padding: EdgeInsets.symmetric(vertical: context.width(.01)),
      margin: EdgeInsets.symmetric(vertical: context.width(.017)),
      color: const Color(0xffFFD688),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PackageSummary(),
              ));
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(ImageUtil.test_image),
        ),
        title: Text(
          "Ikenna Okwara",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: context.width(.04)),
        ),
        subtitle: Row(
          children: [
            SvgPicture.asset(ImageUtil.delivery_star),
            Text(
              " 4/5",
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: context.width(.035)),
            ),
            Text(
              "   10 Deliveries",
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: context.width(.035)),
            ),
          ],
        ),
        trailing: Text(
          " 4/5",
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: context.width(.038)),
        ),
      ),
    );
  }
}
