import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/features/transactions/widget/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../provider/transactions_provider.dart';

class PreviousTransactionsWidget extends StatelessWidget {
  const PreviousTransactionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsProvider>(builder: (_, provider, child) {
      return Column(
        children: [
          !provider.isGetPrevious
              ? Expanded(
                  child: RefreshIndicator(
                    color: Styles.PRIMARY_COLOR,
                    onRefresh: () async {
                      provider.getPreviousTransactions();
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        if (provider.previousTransactions != null &&
                            provider
                                .previousTransactions!.transactions!.isNotEmpty)
                          ...List.generate(
                              provider
                                  .previousTransactions!.transactions!.length,
                              (index) => TransactionCard(
                                    transactionItem: provider
                                        .previousTransactions!
                                        .transactions![index],
                                    isFinished: true,
                                  )),
                        if (provider.previousTransactions == null ||
                            provider
                                .previousTransactions!.transactions!.isEmpty)
                          EmptyState(
                              txt: getTranslated(
                                  "there_is_no_previous_transactions",
                                  context)),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: ListAnimator(
                    addPadding: true,
                    data: List.generate(
                        10,
                        (index) => Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Styles.LIGHT_GREY_BORDER,
                                          width: 1.h))),
                              child: CustomShimmerContainer(
                                width: context.width,
                                height: 70.h,
                                radius: 0,
                              ),
                            )),
                  ),
                )
        ],
      );
    });
  }
}
