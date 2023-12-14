import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/payment/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../components/checkbox_list_tile.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(builder: (_, provider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w
        ),
        child: CheckBoxListTile(
          title: "${provider.wallet.toStringAsFixed(2)} ${getTranslated("sar", context)} (${getTranslated("wallet", context)}).",
          onChange: provider.onUseWallet,
          check: provider.useWallet,
        ),
      );
    });
  }
}
