import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/transactions/provider/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/tab_widget.dart';
import '../../../data/config/di.dart';
import '../widget/current_transactions_widget.dart';
import '../widget/previous_transactions_widget.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<TransactionsProvider>().getCurrentTransactions();
      sl<TransactionsProvider>().getPreviousTransactions();
    });
    super.initState();
  }

  final List<Widget> widgets = [
    const CurrentTransactionsWidget(),
    const PreviousTransactionsWidget(),
  ];
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
              ///Header
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                        color: Styles.CONTAINER_BACKGROUND_COLOR,
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: List.generate(
                          provider.tabs.length,
                          (index) => Expanded(
                                child: TabWidget(
                                    title: getTranslated(
                                        provider.tabs[index], context),
                                    isSelected: index == provider.tab,
                                    onTab: () => provider.onSelectTab(index)),
                              )),
                    )),
              ),

              ///Body
              Expanded(child: widgets[provider.tab])
            ],
          );
        }),
      ),
    );
  }
}
