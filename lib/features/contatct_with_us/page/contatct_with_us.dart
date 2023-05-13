import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/main_widgets/custom_app_bar.dart';
import 'package:fitariki/main_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ContactWithUs extends StatelessWidget {
  const ContactWithUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: getTranslated("contact_with_us", context),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 24.h),
            physics: const BouncingScrollPhysics(),
            children: [
              CustomButton(
                text: getTranslated("mail", context),
                radius: 50,
                onTap: () {},
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomButton(
                text: getTranslated("twitter", context),
                radius: 50,
                onTap: () {},
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomButton(
                text: getTranslated("website", context),
                radius: 50,
                onTap: () {},
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomButton(
                text: getTranslated("customerـservice", context),
                radius: 50,
                onTap: () {},
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
