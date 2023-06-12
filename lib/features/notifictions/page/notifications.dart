import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../provider/notifications_provider.dart';
import '../widget/delivery_requests_notifications.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

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
              return  Expanded(
                child: Column(
                  children: const [DeliveryRequestsNotifications()],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
