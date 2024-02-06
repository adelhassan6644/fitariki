import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/my_trips_provider.dart';

class DeleteReservation extends StatefulWidget {
  const DeleteReservation({super.key, required this.id, required this.type});

  final int id;
  final String type;

  @override
  State<DeleteReservation> createState() => _DeleteReservationState();
}

class _DeleteReservationState extends State<DeleteReservation> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => setState(() {
            isShow = !isShow;
          }),
          child: const Icon(
            Icons.more_horiz,
            color: Styles.HINT_COLOR,
            size: 24,
          ),
        ),
        AnimatedCrossFade(
          crossFadeState:
              isShow ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
          firstChild: Consumer<MyTripsProvider>(builder: (_, provider, child) {
            return InkWell(
              onTap: () =>
                  provider.deleteReservation(id: widget.id, type: widget.type),
              child: Container(
                width: context.width * 0.25,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL.w,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 1.w,
                  vertical: 1.h,
                ),
                decoration: BoxDecoration(
                  color: Styles.WHITE_COLOR,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54.withOpacity(0.2),
                        blurRadius: 7.0,
                        spreadRadius: -1,
                        offset: const Offset(0, 2))
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        getTranslated("delete", context),
                        style: AppTextStyles.w400
                            .copyWith(fontSize: 11, color: Styles.RED_COLOR),
                      ),
                    ),
                    customImageIconSVG(
                        imageName: SvgImages.delete, color: Styles.RED_COLOR)
                  ],
                ),
              ),
            );
          }),
          secondChild: const SizedBox(),
        )
      ],
    );
  }
}
