import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/count_down.dart';
import '../../../components/custom_app_bar.dart';
import '../provider/firebase_auth_provider.dart';

class Verification extends StatelessWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FirebaseAuthProvider>(builder: (child, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
                title: getTranslated("verify_the_phone", context),
                withBorder: true),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            getTranslated(
                                "enter_the_6_digit_code_sent_to", context),
                            style: AppTextStyles.w600.copyWith(
                              fontSize: 16,
                            )),
                        Text(provider.phoneTEC.text.trim().hiddenNumber(),
                            style: AppTextStyles.w600.copyWith(
                              fontSize: 16,
                            )),
                        SizedBox(height: 8.h),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                            length: 6,
                            hintCharacter: "*",
                            autoFocus: true,
                            hintStyle: AppTextStyles.w500
                                .copyWith(color: Styles.DISABLED),
                            appContext: context,
                            keyboardType: TextInputType.phone,
                            animationType: AnimationType.slide,
                            obscureText: true,
                            obscuringCharacter: "*",
                            onCompleted: (v) => provider.sendOTP(code: v),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            cursorColor: Styles.PRIMARY_COLOR,
                            errorTextSpace: 30.h,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                            ],
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              fieldHeight: 38.h,
                              fieldWidth: 42.w,
                              borderWidth: 1.w,
                              fieldOuterPadding: EdgeInsets.zero,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_DEFAULT),
                              selectedColor:
                                  Styles.SECOUND_PRIMARY_COLOR,
                              selectedFillColor: Styles.FILL_COLOR,
                              inactiveFillColor: Styles.FILL_COLOR,
                              inactiveColor:
                                  Styles.SECOUND_PRIMARY_COLOR,
                              activeColor: Styles.SECOUND_PRIMARY_COLOR,
                              activeFillColor: Styles.FILL_COLOR,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: true,
                            beforeTextPaste: (text) => true,
                            onChanged: (v) {},
                          ),
                        ),
                        CountDown(
                          onCount: () => provider.signInWithMobileNo(
                              fromVerification: true),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
