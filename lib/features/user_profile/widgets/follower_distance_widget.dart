import 'package:flutter/cupertino.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../followers/followers/model/followers_model.dart';

class FollowerDistanceWidget extends StatelessWidget {
 final FollowersModel? follwers;
   const FollowerDistanceWidget({Key? key, required this.follwers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated("followers", context),
            style: AppTextStyles.w600.copyWith(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),

          Column(
              children: List.generate(
                follwers!.data?.length??0,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      follwers!.data![index].name??"",
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: AppTextStyles.w600.copyWith(
                          fontSize: 13, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  customImageIconSVG(
                      imageName:     follwers!.data![index].gender==0? SvgImages.maleIcon:SvgImages.femaleIcon,
                      color: ColorResources.BLUE_COLOR,
                      width: 11,
                      height: 11),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 10,
                      width: 1,
                      color: ColorResources.HINT_COLOR,
                      child: const SizedBox(),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "يبعد عنك ",
                      style: AppTextStyles.w400.copyWith(
                          fontSize: 10,
                          color: ColorResources.SECOUND_PRIMARY_COLOR),
                      children: <TextSpan>[
                        TextSpan(
                          text: "2.5 كيلو",
                          style: AppTextStyles.w700.copyWith(
                              fontSize: 10,
                              color: ColorResources.PRIMARY_COLOR),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
