import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/auth_provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key, required this.fromRegister}) : super(key: key);
  final bool fromRegister;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
          appBar: CustomAppBar(
            withBorder: true,
            title: getTranslated(
                widget.fromRegister ? "reset_new_password" : "reset_password",
                context),
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
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Text(
                            getTranslated(
                                widget.fromRegister
                                    ? "new_password_header"
                                    : "reset_password_header",
                                context),
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  getTranslated(
                                      widget.fromRegister
                                          ? "password"
                                          : "new_password",
                                      context),
                                  style:
                                      AppTextStyles.w600.copyWith(fontSize: 16),
                                ),
                              ),
                              CustomTextFormField(
                                valid: Validations.password,
                                controller: provider.newPasswordTEC,
                                hint: "***********",
                                inputType: TextInputType.visiblePassword,
                                isPassword: true,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  getTranslated(
                                      widget.fromRegister
                                          ? "confirm_password"
                                          : "confirm_new_password",
                                      context),
                                  style:
                                      AppTextStyles.w600.copyWith(fontSize: 16),
                                ),
                              ),
                              CustomTextFormField(
                                valid: (v) => Validations.confirmPassword(
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
                                provider.resetPassword(widget.fromRegister);
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
