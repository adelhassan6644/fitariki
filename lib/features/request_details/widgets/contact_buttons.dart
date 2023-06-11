import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_images.dart';

class ContactButtons extends StatelessWidget {
  const ContactButtons({required this.phone, Key? key}) : super(key: key);
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            launch("whatsapp://send?phone=$phone");
          },
          child: customImageIconSVG(
              imageName: SvgImages.whatsApp,
              width: 24,
              height: 24,
              color: ColorResources.PRIMARY_COLOR),
        ),
        SizedBox(
          width: 12.w,
        ),
        InkWell(
          onTap: () {
            launch("tel://$phone");
          },
          child: customImageIconSVG(
              imageName: SvgImages.phoneCallIcon,
              width: 24,
              height: 24,
              color: ColorResources.PRIMARY_COLOR),
        )
      ],
    );
  }
}
