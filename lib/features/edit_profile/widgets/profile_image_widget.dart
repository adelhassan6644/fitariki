import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../helpers/image_picker_helper.dart';
import '../../../main_widgets/custom_images.dart';
import '../../../main_widgets/custom_network_image.dart';
import '../provider/edit_profile_provider.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({required this.provider,Key? key}) : super(key: key);
  final EditProfileProvider provider;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: GestureDetector(
        onTap: () {
          ImagePickerHelper.showOptionSheet(
              onGet: provider.onSelectImage
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            provider.profileImage != null ?ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 115,
                width: 115,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: ColorResources.PRIMARY_COLOR,width: 1)
                ),
                child: Image.file(
                  provider.profileImage!,
                  height: 115,
                  width: 115,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                      child: Container(
                          height: 115,
                          width: 115,
                          color: Colors.grey,
                          child: const Center(child: Icon(Icons.replay, color: Colors.green)))),
                ),
              ),
            )
                : CustomNetworkImage.circleNewWorkImage(
                color: ColorResources.PRIMARY_COLOR,
                image: "",
                radius: 57.5),
            Container(
                height: 115,
                width: 115,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorResources.PRIMARY_COLOR,),
                    color: ColorResources.HINT_COLOR.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(100)
                ),child:const SizedBox()),
            customImageIconSVG(imageName: SvgImages.editor, height: 24,
              width: 24,color: ColorResources.WHITE_COLOR),
          ],
        ),
      ),
    );
  }
}
