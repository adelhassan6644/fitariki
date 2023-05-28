import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../profile/provider/profile_provider.dart';
import '../widegts/ratting_card.dart';

class Ratting extends StatelessWidget {
  const Ratting({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: sl<ProfileProvider>().isDriver
                ? getTranslated("clients_evaluation", context)
                : getTranslated("captain_evaluation", context),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 16.h),
            physics: const BouncingScrollPhysics(),
            children: [
              ...List.generate(
                  5,
                  (index) => RattingCard(
                        isSeen: index == 0 || index == 1 ? false : true,
                      ))
            ],
          ))
        ],
      ),
    );
  }
}
