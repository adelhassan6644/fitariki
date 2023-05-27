import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/offer_card.dart';
import '../../more/widgets/profile_card.dart';
import '../../offer_details/widgets/car_details.dart';
import '../../profile/provider/profile_provider.dart';
import '../../wishlist/provider/wishlist_provider.dart';
import '../widgets/follower_distance_widget.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              CustomAppBar(
                withSave: true,
                onSave: () {
                  if (sl<ProfileProvider>().isLogin) {
                    sl<WishlistProvider>().postWishList(userId: 1);
                  }
                },
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT.w),
                child: const ProfileCard(
                  distance: "2.5 كيلو",
                ),
              ),


            ],
          ),
          Expanded(
            child: ListAnimator(
              data:  [
                SizedBox(height: 12.h,),
                if (!sl<ProfileProvider>().isDriver)  const CarDetails(),
                if (sl<ProfileProvider>().isDriver)  const FollowerDistanceWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: 16.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          sl.get<ProfileProvider>().isDriver
                              ? getTranslated("current_requests", context)
                              : getTranslated("current_offers", context),
                          style:
                          AppTextStyles.w600.copyWith(fontSize: 16),
                        ),
                      ),
                      InkWell(

                        child: Text(
                          getTranslated("view_all", context),
                          style: AppTextStyles.w400.copyWith(
                              fontSize: 11,
                              color: ColorResources.DISABLED),
                        ),
                      )
                    ],
                  ),
                ),
               ... List.generate(
                    sl<HomeProvider>().offer?.length ?? 0,
                        (index) => OfferCard(
                        offerModel:  sl<HomeProvider>().offer![index]))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
