import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../helpers/image_picker_helper.dart';
import '../provider/profile_provider.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget(
      {required this.provider, required this.fromLogin, Key? key})
      : super(key: key);
  final ProfileProvider provider;
  final bool fromLogin;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (fromLogin) {
                ImagePickerHelper.showOptionSheet(
                    onGet: provider.onSelectImage);
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                provider.profileImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 115,
                          width: 115,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: ColorResources.PRIMARY_COLOR,
                                  width: 1)),
                          child: Image.file(
                            provider.profileImage!,
                            height: 115,
                            width: 115,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                                    child: Container(
                                        height: 115,
                                        width: 115,
                                        color: Colors.grey,
                                        child: const Center(
                                            child: Icon(Icons.replay,
                                                color: Colors.green)))),
                          ),
                        ),
                      )
                    : CustomNetworkImage.circleNewWorkImage(
                        color: ColorResources.PRIMARY_COLOR,
                        image: provider.image,
                        radius: 57.5),
                if(fromLogin)  Container(
                        height: 115,
                        width: 115,
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
          if(!fromLogin) Column(
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        ImagePickerHelper.showOptionSheet(
                            onGet: provider.onSelectImage);
                      },
                      child: Text(getTranslated("edit", context),
                          style: AppTextStyles.w400.copyWith(
                              fontSize: 10,
                              color: ColorResources.SYSTEM_COLOR)),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
