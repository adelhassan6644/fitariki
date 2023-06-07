import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/components/shimmer/custom_shimmer.dart';
import 'package:fitariki/features/feedback/provider/feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../../profile/provider/profile_provider.dart';
import '../widegts/feedback_card.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: Column(
          children: [
            CustomAppBar(
              title: sl<ProfileProvider>().isDriver
                  ? getTranslated("clients_evaluation", context)
                  : getTranslated("captain_evaluation", context),
            ),
            Expanded(child:
                Consumer<FeedbackProvider>(builder: (_, provider, child) {
              return ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    vertical: 16.h),
                physics: const BouncingScrollPhysics(),
                children: provider.isLoading
                    ? List.generate(5, (index) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: CustomShimmerContainer(
                                height: 90.h,
                                radius: 8,
                              ),
                            ))
                    : provider.feedbackModel!.feedbacks!.isNotEmpty
                        ? List.generate(provider.feedbackModel!.feedbacks!.length,
                            (index) => FeedbackCard(feedback: provider.feedbackModel!.feedbacks![index],))
                        : [EmptyState(
                              txt: getTranslated("there_is_no_evaluations", context),
                            ),],
              );
            }))
          ],
        ),
      ),
    );
  }
}
