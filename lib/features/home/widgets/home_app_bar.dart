import 'package:fitariki/features/post_offer/provider/post_offer_provider.dart';
import 'package:flutter/material.dart';
import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/marquee_widget.dart';
import '../../auth/pages/login.dart';
import '../../auth/provider/firebase_auth_provider.dart';
import '../../post_offer/page/post_offer.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        color: ColorResources.WHITE_COLOR,
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
                              style: AppTextStyles.w600.copyWith(fontSize: 13)),
                          MarqueeWidget(
                            child: Text(
                                "طريق بدون اسم، مطار الملك خالد الدولـي ز مدينة الرياض في المملكة العربية السعودية",
                                maxLines: 1,
                                style: AppTextStyles.w400.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 11,
                                    color: ColorResources.HINT_COLOR)),
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
              Consumer<FirebaseAuthProvider>(
                builder: (_, provider, child) {
                  return InkWell(
                    child: const Icon(
                      Icons.add,
                      size: 24,
                    ),
                    onTap: () => customShowModelBottomSheet(
                      onClose: Provider.of<PostOfferProvider>(context, listen: false).reset,
                      body: provider.isLogin ? const PostOffer() : const Login(),
                    ),
                  );
                },
              )
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
        ],
      ),
    );
  }
}
