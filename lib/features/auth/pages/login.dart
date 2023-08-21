import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/validation.dart';
import 'package:fitariki/features/auth/pages/register.dart';
import 'package:fitariki/features/auth/provider/auth_provider.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/tab_widget.dart';
import '../../../navigation/routes.dart';

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
      height: 500,
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
                        const SizedBox(height: 16),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  getTranslated("enter_your_mail", context),
                                  style:
                                      AppTextStyles.w600.copyWith(fontSize: 16),
                                ),
                              ),
                              CustomTextFormField(
                                valid: Validations.mail,
                                controller: provider.mailTEC,
                                hint: "xxxxxxx@xxxx.com",
                                inputType: TextInputType.emailAddress,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  getTranslated("password", context),
                                  style:
                                      AppTextStyles.w600.copyWith(fontSize: 16),
                                ),
                              ),
                              CustomTextFormField(
                                valid: Validations.password,
                                controller: provider.currentPasswordTEC,
                                hint: "***********",
                                inputType: TextInputType.visiblePassword,
                                isPassword: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        _ForgetPassword(onTap: provider.clear),
                      ],
                    ),
                  ),
                  SafeArea(
                    top: false,
                    bottom: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: 8),
                      child: Column(
                        children: [
                          CustomButton(
                              text: getTranslated("login", context),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  provider.logIn();
                                }
                              },
                              isLoading: provider.isLoading),
                          const SizedBox(height: 16),
                          CustomButton(
                              text: getTranslated("register", context),
                              textColor: Styles.PRIMARY_COLOR,
                              backgroundColor: Styles.WHITE_COLOR,
                              withBorderColor: true,
                              onTap: () {
                                CustomNavigator.pop();
                                provider.clear();
                                customShowModelBottomSheet(
                                    body: const Register());
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

class _ForgetPassword extends StatelessWidget {
  const _ForgetPassword({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          CustomNavigator.pop();
          onTap();
          CustomNavigator.push(Routes.RESET_PASSWORD, arguments: true);
        },
        child: RichText(
          text: TextSpan(
              text: "هل ",
              style: AppTextStyles.w500
                  .copyWith(fontSize: 14, color: Styles.SECOUND_PRIMARY_COLOR),
              children: [
                TextSpan(
                  text: getTranslated("forget_password", context),
                  style: AppTextStyles.w500.copyWith(
                      fontSize: 14,
                      // decoration: TextDecoration.underline,
                      color: Styles.SYSTEM_COLOR),
                ),
                TextSpan(
                  text: "؟",
                  style: AppTextStyles.w500.copyWith(
                      fontSize: 14, color: Styles.SECOUND_PRIMARY_COLOR),
                )
              ]),
        ));
  }
}
