import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/cupertino.dart';

import '../app/core/utils/color_resources.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import 'custom_images.dart';

class AddressPointerWidget extends StatelessWidget {
  const AddressPointerWidget({super.key, required this.address, this.isCancel});
  final List<String> address;
  final bool? isCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          address.length,
          (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      customImageIconSVG(
                          imageName: SvgImages.dotIcon, width: 10, height: 10),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          address[index],
                          style: AppTextStyles.w400.copyWith(
                              fontSize: 10,
                              overflow: TextOverflow.ellipsis,
                              height: 1.4,
                              color: Styles.DISABLED),
                        ),
                      ),
                      const SizedBox(width: 8),

                      ///Status
                      address.length - 1 == index
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: isCancel == true
                                    ? Styles.PENDING.withOpacity(0.1)
                                    : Styles.ACTIVE.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                getTranslated(
                                    isCancel == false ? "confirmed" : "absent",
                                    context),
                                style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                    color: isCancel == true
                                        ? Styles.ACTIVE
                                        : Styles.PENDING),
                              ),
                            )
                          : const SizedBox(
                              width: 35,
                            ),
                    ],
                  ),
                  Visibility(
                    visible: address.length - 1 != index,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 4),
                      child: Container(
                        height: 12,
                        width: 2,
                        color: Styles.HINT_COLOR,
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}
