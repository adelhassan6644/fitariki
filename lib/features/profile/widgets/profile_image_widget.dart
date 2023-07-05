import 'dart:io';

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/image_pop_up_viewer.dart';
import '../../../helpers/image_picker_helper.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    required this.fromLogin,
    this.withEdit = true,
    Key? key,
    this.radius = 57.5,
    this.image,
    this.imageFile,
    this.onSelectImage,
  }) : super(key: key);
  final bool fromLogin, withEdit;
  final double radius;
  final String? image;
  final File? imageFile;
  final dynamic Function(File?)? onSelectImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              if (fromLogin) {
                ImagePickerHelper.showOptionSheet(onGet: onSelectImage);
              } else {
                if (imageFile != null || image != null) {
                  showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.75),
                      builder: (context) {
                        return ImagePopUpViewer(
                          image: imageFile ?? image,
                          isFromInternet: imageFile != null ? false : true,
                          title: "",
                        );
                      });
                }
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: radius * 2,
                          width: radius * 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: ColorResources.PRIMARY_COLOR,
                                  width: 1)),
                          child: Image.file(
                            imageFile!,
                            height: radius * 2,
                            width: radius * 2,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                                    child: Container(
                                        height: radius * 2,
                                        width: radius * 2,
                                        color: Colors.grey,
                                        child: const Center(
                                            child: Icon(Icons.replay,
                                                color: Colors.green)))),
                          ),
                        ),
                      )
                    : CustomNetworkImage.circleNewWorkImage(
                        color: ColorResources.PRIMARY_COLOR,
                        image: image,
                        radius: radius),
                if (fromLogin)
                  Container(
                      height: radius * 2,
                      width: radius * 2,
                      padding: const EdgeInsets.all(47),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorResources.PRIMARY_COLOR,
                          ),
                          color: ColorResources.HINT_COLOR.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(100)),
                      child: customImageIconSVG(
                          imageName: SvgImages.editor,
                          height: 24,
                          width: 24,
                          color: ColorResources.WHITE_COLOR)),
              ],
            ),
          ),
          if (!fromLogin && withEdit)
            Column(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                GestureDetector(
                  onTap: () {
                    ImagePickerHelper.showOptionSheet(onGet: onSelectImage);
                  },
                  child: Text(getTranslated("edit", context),
                      style: AppTextStyles.w400.copyWith(
                          fontSize: 10, color: ColorResources.SYSTEM_COLOR)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
