import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../app/core/utils/images.dart';
import '../../components/custom_button.dart';
import '../../components/custom_images.dart';
import 'model/success_model.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({required this.successModel, Key? key}) : super(key: key);
  final SuccessModel successModel;

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    if (widget.successModel.isPopUp) {
      Future.delayed(const Duration(seconds: 2), () {
        widget.successModel.onTap?.call();
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: customImageIcon(
                    imageName: widget.successModel.isFail
                        ? Images.cancelCircle
                        : Images.doneCircle,
                    width: 165,
                    height: 165),
              ),
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: Text(
                  widget.successModel.title ??
                      getTranslated("congratulations", context),
                  style: AppTextStyles.w600
                      .copyWith(fontSize: 32, color: Styles.PRIMARY_COLOR),
                ),
              ),
              Visibility(
                visible: widget.successModel.description != null,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0.h),
                    child: SubstringHighlight(
                      textAlign: TextAlign.center,
                      text: widget.successModel.description ?? "",
                      term: widget.successModel.term ?? "",
                      textStyle: AppTextStyles.w500.copyWith(
                          fontSize: 16, color: Styles.SECOUND_PRIMARY_COLOR),
                      textStyleHighlight: AppTextStyles.w700.copyWith(
                          fontSize: 16, color: Styles.SECOUND_PRIMARY_COLOR),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !widget.successModel.isPopUp,
                child: Column(
                  children: [
                    CustomButton(
                      text: widget.successModel.btnText ?? "في طريقي",
                      onTap: widget.successModel.onTap,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomButton(
                      onTap: () {
                        CustomNavigator.push(Routes.DASHBOARD,
                            arguments: 0, clean: true);
                      },
                      text: getTranslated("close", context),
                      backgroundColor: Styles.WHITE_COLOR,
                      withBorderColor: true,
                      textColor: Styles.PRIMARY_COLOR,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
