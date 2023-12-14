import 'package:fitariki/features/my_offers/provider/my_offers_provider.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/config/di.dart';

class DeleteOfferWidget extends StatelessWidget {
  const DeleteOfferWidget({required this.id, Key? key}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => sl<MyOffersProvider>().deleteMyOffer(id),
      child: Text(
        getTranslated("delete", context),
        style: AppTextStyles.w400
            .copyWith(fontSize: 14, color: Styles.RED_COLOR),
      ),
    );
  }
}
