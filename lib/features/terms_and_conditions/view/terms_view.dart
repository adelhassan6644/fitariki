import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_widget.dart';
import '../provider/terms_provider.dart';

class TermsView extends StatelessWidget {
  const TermsView({Key? key, required this.isDriver}) : super(key: key);
  final bool isDriver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: getTranslated("terms_and_conditions", context),
              ),
              Consumer<TermsProvider>(builder: (_, provider, child) {
                return !provider.isLoading
                    ? Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                              vertical: 12.h),
                          child: ListAnimator(
                            data: [
                              provider.termsForDriver != null
                                  ? HtmlWidget(isDriver
                                      ? provider.termsForDriver ?? ""
                                      : provider.termsForClient ?? "")
                                  : EmptyState(
                                      txt: getTranslated(
                                          "something_went_wrong", context))
                            ],
                          ),
                        ),
                      )
                    : const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorResources.PRIMARY_COLOR,
                          ),
                        ),
                      );
              }),
            ],
          )),
    );
  }
}
