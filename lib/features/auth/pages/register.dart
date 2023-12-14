import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/validation.dart';
import 'package:fitariki/features/auth/provider/auth_provider.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/tab_widget.dart';
import '../../../navigation/routes.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 460,
      width: context.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                height: 5.h,
                width: 36.w,
                decoration: BoxDecoration(
                    color: const Color(0xFF3C3C43).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(100)),
                child: const SizedBox(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              getTranslated("register", context),
              style: AppTextStyles.w600.copyWith(
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 1,
              width: context.width,
              color: Styles.LIGHT_GREY_BORDER,
              child: const SizedBox(),
            ),
          ),
          Consumer<AuthProvider>(builder: (_, provider, child) {
            return Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: 12),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Container(
                            height: 32,
                            decoration: BoxDecoration(
                                color: Styles.CONTAINER_BACKGROUND_COLOR,
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              children: List.generate(
                                  provider.usersTypes.length,
                                  (index) => Expanded(
                                        child: TabWidget(
                                            title: getTranslated(
                                                provider.usersTypes[index],
                                                context),
                                            isSelected:
                                                index == provider.userType,
                                            onTab: () => provider
                                                .selectedUserType(index)),
                                      )),
                            )),
                        const SizedBox(
                          height: 24,
                        ),

                        ///E-mail
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated("enter_your_mail", context),
                                style:
                                    AppTextStyles.w600.copyWith(fontSize: 16),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: CustomTextFormField(
                                  valid: Validations.mail,
                                  controller: provider.mailTEC,
                                  hint: "xxxxxxx@xxxx.com",
                                  inputType: TextInputType.emailAddress,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        _AgreeToTerms(
                          onChange: provider.onAgree,
                          check: provider.isAgree,
                          isDriver: provider.userType == 1,
                        )
                      ],
                    ),
                  ),
                  SafeArea(
                    top: false,
                    bottom: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: 12),
                      child: Column(
                        children: [
                          CustomButton(
                              text: getTranslated("follow", context),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (provider.isAgree) {
                                    provider.register();
                                  } else {
                                    showToast(getTranslated(
                                        "please_agree_to_the_terms_and_conditions",
                                        context));
                                  }
                                }
                              },
                              isLoading: provider.isRegister),
                          const SizedBox(height: 16),
                          CustomButton(
                              text: getTranslated("login", context),
                              textColor: Styles.PRIMARY_COLOR,
                              backgroundColor: Styles.WHITE_COLOR,
                              withBorderColor: true,
                              onTap: () {
                                CustomNavigator.pop();
                                provider.clear();
                                customShowModelBottomSheet(body: const Login());
                              }),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _AgreeToTerms extends StatelessWidget {
  const _AgreeToTerms({
    Key? key,
    this.check = false,
    required this.isDriver,
    required this.onChange,
  }) : super(key: key);
  final bool check;
  final Function(bool) onChange;
  final bool isDriver;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () => onChange(!check),
          child: Container(
            width: 18.w,
            height: 18.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Styles.WHITE_COLOR,
                border: Border.all(
                    color:
                        check ? Styles.SECOUND_PRIMARY_COLOR : Styles.DISABLED,
                    width: 1)),
            child: check
                ? const Icon(
                    Icons.check,
                    color: Styles.SECOUND_PRIMARY_COLOR,
                    size: 14,
                  )
                : null,
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          getTranslated("agree_to", context),
          style: AppTextStyles.w500
              .copyWith(fontSize: 14, color: Styles.SECOUND_PRIMARY_COLOR),
        ),
        InkWell(
          onTap: () => CustomNavigator.push(Routes.TERMS_AND_CONDITIONS,
              arguments: isDriver),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          child: Text(
            getTranslated("terms_and_conditions", context),
            style: AppTextStyles.w500.copyWith(
                fontSize: 14,
                // decoration: TextDecoration.underline,
                color: Styles.SYSTEM_COLOR),
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }
}
