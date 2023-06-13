import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/custom_button.dart';
import 'package:fitariki/features/notifications/model/notifications_model.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {this.isRequest = false, required this.notificationItem, Key? key})
      : super(key: key);
  final bool isRequest;
  final NotificationItem notificationItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 16.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: ColorResources.LIGHT_GREY_BORDER, width: 1))),
        child: Row(
          children: [
            Expanded(
              child: Text(
                notificationItem.message ?? "",
                maxLines: 1,
                style: AppTextStyles.w400
                    .copyWith(fontSize: 14, overflow: TextOverflow.ellipsis),
              ),
            ),
            if (isRequest)
              SizedBox(
                width: 40.w,
              ),
            if (isRequest)
              CustomButton(
                onTap: () {},
                text: getTranslated("preview", context),
                radius: 100,
                width: 70,
                textSize: 12,
                height: 30,
              )
          ],
        ),
      ),
    );
  }
}
