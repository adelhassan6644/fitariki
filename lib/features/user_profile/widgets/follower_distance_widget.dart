import 'package:flutter/cupertino.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';
import '../../followers/followers/model/followers_model.dart';
import '../../maps/provider/location_provider.dart';

class FollowerDistanceWidget extends StatelessWidget {
  final FollowersModel? followers;
  final bool isLoading;
  const FollowerDistanceWidget(
      {Key? key, required this.followers, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isLoading &&
          followers != null &&
          followers!.data != null &&
          followers!.data!.isNotEmpty,
      child: Padding(
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
              followers?.data?.length ?? 0,
              (index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        followers!.data![index].name ?? "",
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
                        imageName: followers!.data![index].gender == 0
                            ? SvgImages.maleIcon
                            : SvgImages.femaleIcon,
                        color: Styles.BLUE_COLOR,
                        width: 11,
                        height: 11),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 10,
                        width: 1,
                        color: Styles.HINT_COLOR,
                        child: const SizedBox(),
                      ),
                    ),
                    FutureBuilder(
                      future: Methods.calcDistanceFromCurrentLocation(
                          location: followers!.data![index].pickupLocation),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return RichText(
                          text: TextSpan(
                            text: "يبعد عنك ",
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 10,
                                color: Styles.SECOUND_PRIMARY_COLOR),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    "  ${snapshot.hasData ? snapshot.data ?? "" : "..."} كيلو",
                                style: AppTextStyles.w700.copyWith(
                                    fontSize: 10, color: Styles.PRIMARY_COLOR),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
