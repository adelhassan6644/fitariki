import 'package:flutter/material.dart';

import '../app/core/utils/color_resources.dart';
import '../app/core/utils/dimensions.dart';
import '../app/core/utils/text_styles.dart';

class ExpansionTileWidget extends StatelessWidget {
  const ExpansionTileWidget(
      {required this.title,
      required this.children,
      this.childrenPadding,
      this.withTitlePadding = false,
      this.iconColor,
      Key? key})
      : super(key: key);
  final String title;
  final List<Widget> children;
  final double? childrenPadding;
  final Color? iconColor;
  final bool withTitlePadding;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: AppTextStyles.w600
            .copyWith(fontSize: 14, color: Styles.SECOUND_PRIMARY_COLOR),
      ),
      tilePadding: EdgeInsets.symmetric(
          vertical: withTitlePadding ? 8.h : 0,
          horizontal: withTitlePadding ? Dimensions.PADDING_SIZE_DEFAULT.w : 0),
      childrenPadding: EdgeInsets.all(childrenPadding ?? 0),
      collapsedIconColor: Styles.SECOUND_PRIMARY_COLOR,
      initiallyExpanded: true,
      iconColor: iconColor ?? Styles.SYSTEM_COLOR,
      shape: Border.all(
          color: Colors.transparent, width: 0, style: BorderStyle.none),
      collapsedShape: Border.all(
          color: Colors.transparent, width: 0, style: BorderStyle.none),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
