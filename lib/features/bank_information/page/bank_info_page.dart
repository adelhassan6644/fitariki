import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../profile/provider/profile_provider.dart';
import '../../profile/widgets/bank_data_widget.dart';
import '../widget/edit_bank_data_widget.dart';

class BankInfoPage extends StatelessWidget {
  const BankInfoPage({ Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(

      bottom: true,
      top: false,
      child: Consumer<ProfileProvider>(builder: (_, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(

              actionChild: GestureDetector(
                      onTap: () => provider.updateProfile(),
                      child: Text(getTranslated("save", context),
                          style: AppTextStyles.w400.copyWith(
                              fontSize: 10, color: Styles.SYSTEM_COLOR)),
                    ),
              title: getTranslated("edit_bank_data", context),
              withBorder: true),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Visibility(
                              visible: provider.isDriver,
                              child: EditBankDataWidget(
                                provider: provider,
                                fromLogin: true,
                              )),
                          SizedBox(
                            height: 24.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      }),
    );
  }
}
