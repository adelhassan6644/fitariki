import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/custom_images.dart';
import '../../../main_widgets/marquee_widget.dart';
import '../../../main_widgets/tab_widget.dart';
import '../provider/edit_profile_provider.dart';

class OtherInformationWidget extends StatelessWidget {
  const OtherInformationWidget({required this.provider, Key? key})
      : super(key: key);
  final EditProfileProvider provider;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        getTranslated("other_information", context),
        style: AppTextStyles.w600.copyWith(fontSize: 14),
      ),
      tilePadding: const EdgeInsets.all(0),
      childrenPadding: const EdgeInsets.all(0),
      collapsedIconColor: ColorResources.SECOUND_PRIMARY_COLOR,
      collapsedTextColor: ColorResources.SECOUND_PRIMARY_COLOR,
      initiallyExpanded: true,
      iconColor: ColorResources.SECOUND_PRIMARY_COLOR,
      textColor: ColorResources.SECOUND_PRIMARY_COLOR,
      shape: Border.all(
          color: Colors.transparent, width: 0, style: BorderStyle.none),
      collapsedShape: Border.all(
          color: Colors.transparent, width: 0, style: BorderStyle.none),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated("days", context),
              style: AppTextStyles.w600.copyWith(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                provider.days.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: GestureDetector(
                    onTap: () => provider.onSelectDay(provider.days[index]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                          color: provider.checkSelectDay(provider.days[index])
                              ? ColorResources.PRIMARY_COLOR
                              : ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        provider.days[index],
                        style: AppTextStyles.w400.copyWith(
                          fontSize: 13,
                          height: 1.25,
                          color: provider.checkSelectDay(provider.days[index])
                              ? ColorResources.WHITE_COLOR
                              : ColorResources.SECOUND_PRIMARY_COLOR,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated("time", context),
              style: AppTextStyles.w600.copyWith(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                getTranslated("start", context),
                style: AppTextStyles.w600.copyWith(fontSize: 14),
              ),
            ),
            GestureDetector(
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                    color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(4)),
                child: Text("12:00",
                    style: AppTextStyles.w500.copyWith(
                      fontSize: 13,
                    )),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 170,
              decoration: BoxDecoration(
                  color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.all(2),
              child: Row(
                children: List.generate(
                    provider.timeZones.length,
                    (index) => Expanded(
                          child: TabWidget(
                              backGroundColor: ColorResources.PRIMARY_COLOR,
                              innerVPadding: 2,
                              title: getTranslated(
                                  provider.timeZones[index], context),
                              isSelected: provider.timeZones[index] ==
                                  provider.startTimeZone,
                              onTab: () => provider.selectedStartTimeZone(
                                  provider.timeZones[index])),
                        )),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                getTranslated("end", context),
                style: AppTextStyles.w600.copyWith(fontSize: 14),
              ),
            ),
            GestureDetector(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                    color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(4)),
                child: Text("12:00",
                    style: AppTextStyles.w500.copyWith(
                      fontSize: 13,
                    )),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 170,
              decoration: BoxDecoration(
                  color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.all(2),
              child: Row(
                children: List.generate(
                    provider.timeZones.length,
                    (index) => Expanded(
                          child: TabWidget(
                              backGroundColor: ColorResources.PRIMARY_COLOR,
                              innerVPadding: 2,
                              title: getTranslated(
                                  provider.timeZones[index], context),
                              isSelected: provider.timeZones[index] ==
                                  provider.endTimeZone,
                              onTab: () => provider.selectedEndTimeZone(
                                  provider.timeZones[index])),
                        )),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color:ColorResources.LIGHT_BORDER_COLOR,width: 1 ),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              children: [
                Expanded(
                  child: MarqueeWidget(
                    child: Text("حدد مكان دوامك/دراستك بالخريطه",style: AppTextStyles.w400.copyWith(
                        fontSize: 14,
                        color: ColorResources.DISABLED,
                        overflow: TextOverflow.ellipsis
                    ),),
                  ),
                ),
                const SizedBox(width: 15,),
                customImageIconSVG(imageName: SvgImages.map)
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
