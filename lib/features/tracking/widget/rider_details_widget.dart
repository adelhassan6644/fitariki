import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import 'emergency_bottom_sheet.dart';

class RiderDetailsWidget extends StatelessWidget {
  const RiderDetailsWidget(
      {super.key,
      this.onFinish,
      required this.image,
      required this.name,
      required this.phone,
      required this.whatsApp,
      required this.isDriver});

  final Function()? onFinish;
  final String image, name, phone, whatsApp;
  final bool isDriver;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14.h),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 12.h),
      decoration: const BoxDecoration(
          border: Border.symmetric(
              horizontal:
                  BorderSide(color: Styles.LIGHT_GREY_BORDER, width: 1))),
      child: Row(
        children: [
          CustomNetworkImage.circleNewWorkImage(
              image: image, radius: 22.5, label: name),
          const Expanded(child: SizedBox()),
          customCircleSvgIcon(
              onTap: () async {
                print(phone);
                await launch("tel://$phone");
              },
              imageName: SvgImages.phoneCallIcon,
              width: 20,
              height: 20,
              radius: 22.5,
              label: getTranslated("call", context)),
          const Expanded(child: SizedBox()),
          customCircleSvgIcon(
              onTap: () async {
                if (isDriver) {
                  launch("whatsapp://send?phone=$phone");
                } else {
                  customShowModelBottomSheet(
                      body: EmergencyBottomSheet(
                    onFinish: onFinish,
                  ));
                }
              },
              imageName: isDriver ? SvgImages.whatsApp : SvgImages.emergency,
              width: 20,
              height: 20,
              radius: 22.5,
              label:
                  isDriver ? "Whats App" : getTranslated("emergency", context)),
        ],
      ),
    );
  }
}
