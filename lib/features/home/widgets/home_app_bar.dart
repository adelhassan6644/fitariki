import 'package:fitariki/features/maps/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_images.dart';
import '../../../components/marquee_widget.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  void initState() {
   Future.delayed(Duration.zero,(){
     Provider.of<LocationProvider>(context,listen: false).getCurrentLocation();
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (_, provider, child) {
      return Container(
        decoration: const BoxDecoration(color: Color(0xFFFFF9F9)),
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Column(
          children: [
            SizedBox(
              height: context.toPadding,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      customCircleSvgIcon(
                          imageName: SvgImages.location,
                          color: Styles.WHITE_COLOR,
                          width: 40,
                          height: 40),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getTranslated("current_location", context),
                                style:
                                    AppTextStyles.w600.copyWith(fontSize: 13)),
                            MarqueeWidget(
                              child: Text(
                                  provider.currentLocation?.address ??
                                      "المملكة العربية السعودية",
                                  maxLines: 1,
                                  style: AppTextStyles.w400.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 11,
                                      color: Styles.HINT_COLOR)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ),
                customImageIconSVG(
                  imageName: SvgImages.navLogoIcon,
                  color:Styles.PRIMARY_COLOR ,
                    width: 25,
                    height: 25)

                // Consumer<ProfileProvider>(
                //   builder: (_, provider, child) {
                //     return InkWell(
                //       child: const Icon(
                //         Icons.add,
                //         size: 24,
                //       ),
                //       onTap: () => customShowModelBottomSheet(
                //         onClose: sl.get<PostOfferProvider>().reset,
                //         body: provider.isLogin
                //             ? const PostOffer()
                //             : const Login(),
                //       ),
                //     );
                //   },
                // )
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
          ],
        ),
      );
    });
  }
}
