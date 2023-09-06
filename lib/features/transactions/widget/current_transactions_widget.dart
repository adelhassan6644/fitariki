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

class CurrentTransactionsWidget extends StatelessWidget {
  const CurrentTransactionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsProvider>(builder: (_, provider, child) {
      return Column(
        children: [
          !provider.isGetCurrent
              ? Expanded(
                  child: RefreshIndicator(
                    color: Styles.PRIMARY_COLOR,
                    onRefresh: () async {
                      provider.getCurrentTransactions();
                      provider.getPreviousTransactions();
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 8.h),
                      children: (provider.currentTransactions != null &&
                              provider.currentTransactions!.transactions!
                                  .isNotEmpty)
                          ? List.generate(
                              provider
                                  .currentTransactions!.transactions!.length,
                              (index) => TransactionCard(
                                    transactionItem: provider
                                        .currentTransactions!
                                        .transactions![index],
                                    isFinished: false,
                                  ))
                          : [
                              ///Empty State if there is no transactions
                              Visibility(
                                visible:
                                    (provider.currentTransactions == null ||
                                        provider.currentTransactions!
                                            .transactions!.isEmpty),
                                child: EmptyState(
                                    txt: getTranslated(
                                        "there_is_no_current_transactions", context)),
                              ),
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
