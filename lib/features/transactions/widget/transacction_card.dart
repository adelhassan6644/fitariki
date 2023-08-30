import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/transactions/model/transactions_model.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard(
      {Key? key, required this.transactionItem, required this.isFinished})
      : super(key: key);
  final TransactionItem transactionItem;
  final bool isFinished;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 16.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Styles.LIGHT_GREY_BORDER, width: 1.h))),
      child: Row(
        children: [
          Expanded(
            child: HtmlWidget(
              transactionItem.comment ?? "",
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          CustomButton(
            onTap: () => CustomNavigator.push(Routes.PDF,
                arguments: transactionItem.invoice ?? ""),
            text: getTranslated("preview", context),
            radius: 100,
            width: 100,
            textSize: 12,
            height: 30,
            backgroundColor: isFinished? Styles.WHITE_COLOR:Styles.PRIMARY_COLOR,
            textColor: isFinished? Styles.PRIMARY_COLOR:Styles.WHITE_COLOR,
            withBorderColor: true,
          ),
        ],
      ),
    );
  }
}
