import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/components/empty_widget.dart';
import 'package:fitariki/features/wishlist/provider/wishlist_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../main_widgets/offer_card.dart';
import '../../../main_widgets/shimmer_widgets/shimmer_offer_card.dart';

class FavouriteOffersWidgets extends StatelessWidget {
  const FavouriteOffersWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(builder: (_, provider, child) {
      return Expanded(
          child: ListAnimator(
        data: provider.isLoading
            ? List.generate(
                5,
                (index) => const ShimmerOfferCard(
                  isSaved: true,
                ),
              )
            : provider.favouriteModel!.offers!.isNotEmpty
                ? List.generate(
                    provider.favouriteModel!.offers!.length,
                    (index) => OfferCard(
                        isSaved: true,
                        offerModel: provider.favouriteModel!.offers![index]),
                  )
                : [
                    const EmptyState(
                      txt: "لا يوجد محفوظات !",
                    )
                  ],
      ));
    });
  }
}
