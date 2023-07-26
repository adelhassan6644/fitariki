import 'package:country_picker/country_picker.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/validation.dart';
import 'package:fitariki/features/terms_and_conditions/provider/terms_provider.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/tab_widget.dart';
import '../../../navigation/routes.dart';
import '../provider/firebase_auth_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380.h,
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
              getTranslated("login", context),
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
              color: ColorResources.LIGHT_GREY_BORDER,
              child: const SizedBox(),
            ),
          ),
          Consumer<FirebaseAuthProvider>(builder: (_, provider, child) {
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
                                color:
                                    ColorResources.CONTAINER_BACKGROUND_COLOR,
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
                          height: 16,
                        ),
                        Text(
                          getTranslated("enter_your_mobile_number", context),
                          style: AppTextStyles.w600.copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Form(
                          key: _formKey,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: CustomTextFormField(
                                  controller: provider.phoneTEC,
                                  hint: "5xxxxxxxx",
                                  inputType: TextInputType.phone,
                                  valid: (v) => Validations.phone(
                                      v, provider.countryCode.trim()),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        showPhoneCode: true,
                                        showSearch: false,
                                        countryFilter: [
                                          "SA",
                                          "EG",
                                          "AF",
                                          "IN",
                                          "PK",
                                          "UA",
                                          "BH",
                                          "QA",
                                          "UAE",
                                          "USA",
                                          "RA",
                                        ],
                                        onSelect: (Country value) =>
                                            provider.onSelectCountry(
                                                code: value.countryCode,
                                                phone: value.phoneCode),
                                        countryListTheme: CountryListThemeData(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                          bottomSheetHeight: 360.h,
                                          textStyle: AppTextStyles.w500
                                              .copyWith(fontSize: 14),
                                          flagSize: 20,
                                          searchTextStyle: const TextStyle(
                                            color: ColorResources
                                                .SECOUND_PRIMARY_COLOR,
                                            fontSize: 14,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorResources
                                                  .LIGHT_BORDER_COLOR,
                                              width: 1),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.RADIUS_DEFAULT)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 8),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                              child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            size: 18,
                                            color: ColorResources.PRIMARY_COLOR,
                                          )),
                                          Expanded(
                                            child: Text(
                                              provider.countryPhoneCode,
                                              style: AppTextStyles.w400
                                                  .copyWith(
                                                      fontSize: 14,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                            ),
                                          ),
                                          Expanded(
                                            child: Flag.fromString(
                                              provider.countryCode,
                                              width: 16,
                                              height: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
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
                    bottom: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: 12),
                      child: CustomButton(
                          text: getTranslated("follow", context),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (provider.isAgree) {
                                provider.signInWithMobileNo();
                              } else {
                                showToast(getTranslated(
                                    "please_agree_to_the_terms_and_conditions",
                                    context));
                              }
                            }
                          },
                          isLoading: provider.isLoading),
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
                color: ColorResources.WHITE_COLOR,
                border: Border.all(
                    color: check
                        ? ColorResources.SECOUND_PRIMARY_COLOR
                        : ColorResources.DISABLED,
                    width: 1)),
            child: check
                ? const Icon(
                    Icons.check,
                    color: ColorResources.SECOUND_PRIMARY_COLOR,
                    size: 14,
                  )
                : null,
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          getTranslated("agree_to", context),
          style: AppTextStyles.w500.copyWith(
              fontSize: 14, color: ColorResources.SECOUND_PRIMARY_COLOR),
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
                decoration: TextDecoration.underline,
                color: ColorResources.PRIMARY_COLOR),
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }
}
