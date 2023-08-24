import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/features/profile/model/client_model.dart';
import 'package:fitariki/features/profile/model/driver_model.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/show_rate.dart';
import '../../../data/config/di.dart';
import '../../../navigation/routes.dart';
import '../provider/wishlist_provider.dart';

class FavouriteUserCard extends StatelessWidget {
  const FavouriteUserCard(
      {this.driver, this.client, this.withSaveButton = true, Key? key})
      : super(key: key);
  final DriverModel? driver;
  final ClientModel? client;
  final bool withSaveButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CustomNavigator.push(Routes.USER_PROFILE, arguments: {
        "id": driver != null ? driver!.id : client!.id,
        "my_profile": false
      }),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 8.h),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: Styles.WHITE_COLOR,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54.withOpacity(0.1),
                  blurRadius: 7.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Row(
            children: [
              CustomNetworkImage.circleNewWorkImage(
                  image: driver != null
                      ? driver!.image ?? ""
                      : client!.image ?? "",
                  radius: 16,
                  color: Styles.SECOUND_PRIMARY_COLOR),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            driver != null
                                ? driver!.firstName ?? ""
                                : "${client!.firstName ?? ""} ${client!.lastName ?? ""}",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: AppTextStyles.w600.copyWith(
                                fontSize: 14,
                                height: 1.25,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        customImageIconSVG(
                            imageName: driver != null
                                ? driver!.gender! == 0
                                    ? SvgImages.maleIcon
                                    : SvgImages.femaleIcon
                                : client!.gender! == 0
                                    ? SvgImages.maleIcon
                                    : SvgImages.femaleIcon,
                            color: Styles.BLUE_COLOR,
                            width: 11,
                            height: 11)
                      ],
                    ),
                    ShowRate(
                      rate: driver != null ? driver!.rate : client!.rate,
                    )
                  ],
                ),
              ),
              Visibility(
                visible: withSaveButton,
                child: InkWell(
                  onTap: () => sl<WishlistProvider>().postWishList(
                      id: driver != null ? driver!.id! : client!.id!,
                      isOffer: false),
                  child: customImageIconSVG(imageName: SvgImages.saved),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
