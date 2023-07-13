import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/features/home/provider/home_provider.dart';
import 'package:fitariki/main_models/offer_model.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

import '../app/core/utils/methods.dart';
import '../components/custom_images.dart';
import '../components/custom_network_image.dart';
import '../components/marquee_widget.dart';
import '../components/show_rate.dart';
import '../data/config/di.dart';
import '../features/wishlist/provider/wishlist_provider.dart';
import '../navigation/routes.dart';
import '../features/home/widgets/acceptable_analytics_widget.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({this.isSaved = false, Key? key, required this.offerModel})
      : super(key: key);
  final bool isSaved;
  final OfferModel offerModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          CustomNavigator.push(Routes.OFFER_DETAILS, arguments: offerModel.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: ColorResources.WHITE_COLOR,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54.withOpacity(0.2),
                  blurRadius: 7.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomNetworkImage.circleNewWorkImage(
                            image: sl<HomeProvider>().isDriver
                                ? offerModel.clientModel?.image ?? ""
                                : offerModel.driverModel?.image ?? "",
                            radius: 16,
                            color: ColorResources.SECOUND_PRIMARY_COLOR),
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
                                      sl<HomeProvider>().isDriver
                                          ? "${offerModel.clientModel?.firstName ?? ""} ${offerModel.clientModel?.lastName ?? ""} "
                                          : offerModel.driverModel?.firstName ??
                                              "",
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
                                      imageName: sl<HomeProvider>().isDriver
                                          ? offerModel.clientModel?.gender == 0
                                              ? SvgImages.maleIcon
                                              : SvgImages.femaleIcon
                                          : offerModel.driverModel?.gender == 0
                                              ? SvgImages.maleIcon
                                              : SvgImages.femaleIcon,
                                      color: ColorResources.BLUE_COLOR,
                                      width: 11,
                                      height: 11)
                                ],
                              ),
                              ShowRate(
                                rate: sl<HomeProvider>().isDriver
                                    ? offerModel.clientModel?.rate ?? 0
                                    : offerModel.driverModel?.rate ?? 0,
                              )
                            ],
                          ),
                        ),
                        if (isSaved == true)
                          InkWell(
                            onTap: () => sl<WishlistProvider>().postWishList(
                                id: offerModel.id!, isOffer: true),
                            child:
                                customImageIconSVG(imageName: SvgImages.saved),
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.roadLine),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "${offerModel.duration} يوم",
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  color: ColorResources.HINT_COLOR,
                                  height: 10,
                                  width: 1,
                                  child: const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: isSaved ? 14 : 9,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.calendar),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "${offerModel.offerDays?.length ?? 0} ايام بالإسبوع",
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.alarm),
                              const SizedBox(width: 4),
                              if (offerModel.offerDays != null &&
                                  offerModel.offerDays!.isNotEmpty)
                                Expanded(
                                  child: MarqueeWidget(
                                    child: Text(
                                      "${Methods.convertStringToTime(offerModel.offerDays?[0].startTime ?? DateTime.now(), withFormat: true)}"
                                      " - ${Methods.convertStringToTime(offerModel.offerDays?[0].endTime ?? DateTime.now(), withFormat: true)}ً",
                                      textAlign: TextAlign.start,
                                      style: AppTextStyles.w400.copyWith(
                                          fontSize: 10,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  color: ColorResources.HINT_COLOR,
                                  height: 10,
                                  width: 1,
                                  child: const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: isSaved ? 3 : 5,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.wallet),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "${offerModel.minPrice} - ${offerModel.maxPrice} ريال",
                                    // "400 - 600 ريال",
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (isSaved != true)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Methods.getDayCount(
                        date: offerModel.createdAt!,
                      ).toString(),
                      style: AppTextStyles.w400.copyWith(fontSize: 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AcceptableAnalytics(
                      value: offerModel.matching ?? 0,
                      color: ColorResources.PRIMARY_COLOR,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
