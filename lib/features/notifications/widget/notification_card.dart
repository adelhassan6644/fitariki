import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/custom_button.dart';
import 'package:fitariki/features/notifications/model/notifications_model.dart';
import 'package:fitariki/features/notifications/provider/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({required this.notificationItem, Key? key})
      : super(key: key);

  final NotificationItem notificationItem;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsProvider>(builder: (_, provider, child) {
      return InkWell(
        onTap: () {
          if (widget.notificationItem.notificationData!.routName != null) {
            if (widget.notificationItem.notificationData!.routName ==
                Routes.TRACKING) {
              CustomNavigator.push(
                Routes.TRACKING,
                arguments: widget.notificationItem.notificationData!.rideData,
              );
            } else if (widget.notificationItem.notificationData!.routName ==
                Routes.PAYMENT) {
              CustomNavigator.push(Routes.PAYMENT, arguments: {
                'isFromMyTrips':
                    !widget.notificationItem.notificationData!.isMyOffer!,
                'id': widget.notificationItem.notificationData!.id
              });
            } else {
              CustomNavigator.push(
                widget.notificationItem.notificationData!.routName!,
                arguments: widget.notificationItem.notificationData!.id!,
              );
            }
          }
          provider.readNotification(widget.notificationItem.id);
          setState(() => widget.notificationItem.isRead = true);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 16.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          decoration: BoxDecoration(
              color: widget.notificationItem.isRead == true
                  ? null
                  : Styles.PRIMARY_COLOR.withOpacity(0.1),
              border: Border(
                  bottom:
                      BorderSide(color: Styles.LIGHT_GREY_BORDER, width: 1.h))),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.notificationItem.notificationData?.message ?? "",
                  maxLines: 1,
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 14, overflow: TextOverflow.ellipsis),
                ),
              ),
              Visibility(
                visible: widget.notificationItem.notificationData!.status != 3,
                child: SizedBox(
                  width: 40.w,
                ),
              ),
              Visibility(
                visible: widget.notificationItem.notificationData!.status != 3,
                child: CustomButton(
                  onTap: () {
                    CustomNavigator.push(
                        widget.notificationItem.notificationData!.routName!,
                        arguments:
                            widget.notificationItem.notificationData!.id!);
                  },
                  text: getTranslated("preview", context),
                  radius: 100,
                  width: 70,
                  textSize: 12,
                  height: 30,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
