import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../provider/contact_provider.dart';

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
              child: Consumer<ContactProvider>(builder: (_, provider, child) {
            return ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: 24.h),
              physics: const BouncingScrollPhysics(),
              children: [
                /// Launch Mail
                Visibility(
                  visible: provider.contactModel?.email != null,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 8.h,
                    ),
                    child: CustomButton(
                      text: getTranslated("mail", context),
                      radius: 50,
                      onTap: () => provider.launchMail(),
                    ),
                  ),
                ),

                /// Launch Twitter
                Visibility(
                  visible: provider.contactModel?.twitter != null,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 8.h,
                    ),
                    child: CustomButton(
                      text: getTranslated("twitter", context),
                      radius: 50,
                      onTap: () => provider.launchTwitter(),
                    ),
                  ),
                ),

                ///Launch Website
                Visibility(
                  visible: provider.contactModel?.website != null,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 8.h,
                    ),
                    child: CustomButton(
                      text: getTranslated("website", context),
                      radius: 50,
                      onTap: () => provider.launchWebsite(),
                    ),
                  ),
                ),
                Visibility(
                  visible: provider.contactModel?.phone != null,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 8.h,
                    ),
                    child: CustomButton(
                      text: getTranslated("customerـservice", context),
                      radius: 50,
                      onTap: () => provider.launchCustomerService(),
                    ),
                  ),
                ),

                ///Call Emergency
                Visibility(
                  visible: !provider.isDriver,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 8.h,
                    ),
                    child: CustomButton(
                      text: getTranslated("call_emergency", context),
                      radius: 50,
                      onTap: () => provider.launchEmergencyService(),
                    ),
                  ),
                ),
              ],
            );
          }))
        ],
      ),
    );
  }
}
