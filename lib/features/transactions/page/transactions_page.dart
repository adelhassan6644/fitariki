import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/features/transactions/provider/transactions_provider.dart';
import 'package:fitariki/features/transactions/widget/transacction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../components/tab_widget.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("transactions", context),
      ),
      body: SafeArea(
        top: false,
        child: Consumer<TransactionsProvider>(builder: (_, provider, child) {
          return Column(
            children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              //       vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              //   child: Container(
              //       height: 32,
              //       decoration: BoxDecoration(
              //           color: Styles.CONTAINER_BACKGROUND_COLOR,
              //           borderRadius: BorderRadius.circular(6)),
              //       child: Row(
              //         children: List.generate(
              //             provider.tabs.length,
              //             (index) => Expanded(
              //                   child: TabWidget(
              //                       title: getTranslated(
              //                           provider.tabs[index], context),
              //                       isSelected: index == provider.tab,
              //                       onTab: () => provider.onSelectTab(index)),
              //                 )),
              //       )),
              // ),
              !provider.isLoading
                  ? Expanded(
                      child: RefreshIndicator(
                        color: Styles.PRIMARY_COLOR,
                        onRefresh: () async {
                          provider.getTransactions();
                        },
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            if (provider.transactionsModel != null &&
                                provider.transactionsModel!.transactions!
                                    .isNotEmpty)
                              ...List.generate(
                                  provider
                                      .transactionsModel!.transactions!.length,
                                  (index) => TransactionCard(
                                        transactionItem: provider
                                            .transactionsModel!
                                            .transactions![index],
                                      )),
                            if (provider.transactionsModel == null ||
                                provider
                                    .transactionsModel!.transactions!.isEmpty)
                              EmptyState(
                                  txt: getTranslated(
                                      "there_is_no_transactions", context)),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListAnimator(
                        data: [
                          SizedBox(
                            height: 8.h,
                          ),
                          ...List.generate(
                              6,
                              (index) => Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Styles.LIGHT_GREY_BORDER,
                                                width: 1.h))),
                                    child: CustomShimmerContainer(
                                      width: context.width,
                                      height: 75.h,
                                      radius: 0,
                                    ),
                                  ))
                        ],
                      ),
                    )
            ],
          );
        }),
      ),
    );
  }
}
