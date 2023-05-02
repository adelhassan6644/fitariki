import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/add_offer_provider.dart';
import '../widgets/add_offer_app_bar.dart';
import '../widgets/duration_widget.dart';
import '../widgets/followers_widget.dart';

class AddOffer extends StatelessWidget {
  const AddOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.9,
      width: context.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AddOfferAppBar(),
          Consumer<AddOfferProvider>(builder: (_, provider, child) {
            return Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 12),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  DurationWidget(
                    provider: provider,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FollowersWidget(
                    provider: provider,
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
