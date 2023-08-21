import 'package:fitariki/components/animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/auth_provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
          appBar: CustomAppBar(
            title: getTranslated("change_password", context),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              children: [
                Expanded(
                  child: Consumer<AuthProvider>(builder: (_, provider, child) {
                    return ListAnimator(
                      data: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            getTranslated("change_password_header", context),
                            textAlign: TextAlign.start,
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 16,
                                color: Styles.SECOUND_PRIMARY_COLOR),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///Current Password
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  getTranslated("current_password", context),
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
                              const SizedBox(height: 16),

                              ///New Password
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  getTranslated("new_password", context),
                                  style:
                                      AppTextStyles.w600.copyWith(fontSize: 16),
                                ),
                              ),
                              CustomTextFormField(
                                valid: (v) => Validations.newPassword(
                                    provider.currentPasswordTEC.text.trim(), v),
                                controller: provider.newPasswordTEC,
                                hint: "***********",
                                inputType: TextInputType.visiblePassword,
                                isPassword: true,
                              ),
                              const SizedBox(
                                height: 16,
                              ),

                              ///Confirm New Password
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  getTranslated(
                                      "confirm_new_password", context),
                                  style:
                                      AppTextStyles.w600.copyWith(fontSize: 16),
                                ),
                              ),
                              CustomTextFormField(
                                valid: (v) => Validations.confirmNewPassword(
                                    provider.newPasswordTEC.text.trim(), v),
                                controller: provider.confirmPasswordTEC,
                                hint: "***********",
                                inputType: TextInputType.visiblePassword,
                                isPassword: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        CustomButton(
                            text: getTranslated("save", context),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                provider.changePassword();
                              }
                            },
                            isLoading: provider.isForget),
                      ],
                    );
                  }),
                ),
              ],
            ),
          )),
    );
  }
}
