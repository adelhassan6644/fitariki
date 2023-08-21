import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../provider/notifications_provider.dart';
import '../widget/notification_card.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<NotificationsProvider>(context, listen: false)
          .getNotifications();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Column(
          children: [
            CustomAppBar(
              title: getTranslated("notifications", context),
            ),
            Consumer<NotificationsProvider>(builder: (_, provider, child) {
              return !provider.isLoading
                  ? Expanded(
                      child: RefreshIndicator(
                        color: Styles.PRIMARY_COLOR,
                        onRefresh: () async {
                          provider.getNotifications();
                        },
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            if (provider.notificationsModel != null &&
                                provider.notificationsModel!.notifications!
                                    .isNotEmpty)
                              ...List.generate(
                                  provider.notificationsModel!.notifications!
                                      .length,
                                  (index) => NotificationCard(
                                        notificationItem: provider
                                            .notificationsModel!
                                            .notifications![index],
                                      )),
                            if (provider.notificationsModel == null ||
                                provider
                                    .notificationsModel!.notifications!.isEmpty)
                              EmptyState(
                                  txt: getTranslated(
                                      "there_is_no_notifications", context)),
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
                                      height: 65.h,
                                      radius: 0,
                                    ),
                                  ))
                        ],
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
