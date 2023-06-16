import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../helpers/cupertino_pop_up_helper.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../request_details/provider/request_details_provider.dart';

class MyTripDetailsActionButtons extends StatelessWidget {
  const MyTripDetailsActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestDetailsProvider>(builder: (_, provider, child) {
      return Column(
        children: [
          /// when offer or request is new
          Visibility(
            visible: !provider.isLoading &&
                provider.requestModel?.approvedAt == null &&
                provider.requestModel?.rejectedAt == null,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: 8.h),
                  child: CustomButton(
                    text: provider.isDriver
                        ? getTranslated("accept_request", context)
                        : getTranslated("accept_offer", context),
                    onTap: () => provider.updateRequest(
                        fromMyTrip: true,
                        name: provider.isDriver
                            ? "${provider.requestModel?.offer?.clientModel?.firstName ?? ""} ${provider.requestModel?.offer?.clientModel?.firstName ?? ""}"
                            : provider.requestModel?.offer?.driverModel
                                    ?.firstName ??
                                "",
                        status: 1,
                        id: provider.requestModel!.id!),
                    isLoading: provider.isAccepting,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: CustomButton(
                    text: getTranslated("negotiation", context),
                    backgroundColor: ColorResources.WHITE_COLOR,
                    withBorderColor: true,
                    textColor: ColorResources.PRIMARY_COLOR,
                    onTap: () =>
                        CupertinoPopUpHelper.showCupertinoTextController(
                            title: getTranslated("negotiation", context),
                            description: getTranslated(
                                "negotiation_description", context),
                            controller: provider.negotiationPrice,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            onSend: () {
                              provider.updateRequest(
                                  fromMyTrip: true,
                                  status: 2,
                                  id: provider.requestModel!.id!);
                              CustomNavigator.pop();
                            },
                            onClose: () {
                              provider.negotiationPrice.clear();
                            }),
                    isLoading: provider.isNegotiation,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: CustomButton(
                    text: provider.isDriver
                        ? getTranslated("reject_request", context)
                        : getTranslated("reject_offer", context),
                    backgroundColor: ColorResources.WHITE_COLOR,
                    withBorderColor: true,
                    textColor: ColorResources.PRIMARY_COLOR,
                    onTap: () => provider.updateRequest(
                        fromMyTrip: true,
                        status: 3,
                        id: provider.requestModel!.id!),
                    isLoading: provider.isRejecting,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                )
              ],
            ),
          ),

          /// when request accepted but not paid and current type is client
          Visibility(
            visible: !provider.isLoading &&
                provider.requestModel?.approvedAt != null &&
                provider.requestModel?.paidAt == null &&
                !provider.isDriver,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: 16.h),
              child: CustomButton(
                onTap: () =>
                    CustomNavigator.push(Routes.PAYMENT, arguments: true),
                text: getTranslated("payment", context),
              ),
            ),
          ),

          /// when request accepted but not paid and current type is driver
          Visibility(
            visible: !provider.isLoading &&
                provider.requestModel?.approvedAt != null &&
                provider.requestModel?.paidAt == null &&
                provider.isDriver,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: 16.h),
              child: CustomButton(
                textColor: ColorResources.PRIMARY_COLOR,
                backgroundColor: ColorResources.PRIMARY_COLOR.withOpacity(0.1),
                text: getTranslated("request_accepted", context),
              ),
            ),
          ),

          /// when offer rejected
          Visibility(
            visible: !provider.isLoading &&
                provider.requestModel?.rejectedAt != null &&
                provider.requestModel?.approvedAt == null,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: 16.h),
              child: CustomButton(
                textColor: ColorResources.PRIMARY_COLOR,
                backgroundColor: ColorResources.PRIMARY_COLOR.withOpacity(0.1),
                text: getTranslated(
                    provider.isDriver ? "request_rejected" : "offer_rejected",
                    context),
              ),
            ),
          ),
        ],
      );
    });
  }
}