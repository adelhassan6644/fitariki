import 'package:flutter/cupertino.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(getTranslated("welcome", context),
              style: AppTextStyles.w600
                  .copyWith(fontSize: 32, color: ColorResources.PRIMARY_COLOR)),
        ),
        Center(
          child: Text(getTranslated("welcome_description", context),
              textAlign: TextAlign.center,
              style: AppTextStyles.w500.copyWith(
                fontSize: 16,
              )),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
