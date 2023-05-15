import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import 'notification_card.dart';

class DeliveryOrdersNotifications extends StatelessWidget {
  const DeliveryOrdersNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      padding: EdgeInsets.only(bottom: 12.h),
      physics: const BouncingScrollPhysics(),
      children: [
        ...List.generate(15, (index) => const NotificationCard()),
      ],
    ));
  }
}
