import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/auth_provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
          appBar: CustomAppBar(
            title: "${getTranslated("forget_password", context)}؟",
            withBorder: true,
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
                        Text(
                          getTranslated("forget_password_header", context),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.w600.copyWith(
                              fontSize: 16,
                              color: Styles.SECOUND_PRIMARY_COLOR),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            getTranslated(
                                "forget_password_sub_header", context),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 14,
                                color: Styles.SECOUND_PRIMARY_COLOR),
                          ),
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: CustomTextFormField(
                                    valid: Validations.mail,
                                    controller: provider.mailTEC,
                                    hint: "xxxxxxx@xxxx.com",
                                    inputType: TextInputType.emailAddress,
                                  ),
                                ),
                                Center(
                                  child: CustomButton(
                                      text: getTranslated("follow", context),
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          provider.forgetPassword();
                                        }
                                      },
                                      isLoading: provider.isForget),
                                ),
                              ],
                            )),
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
