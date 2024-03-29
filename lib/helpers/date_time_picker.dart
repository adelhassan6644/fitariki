import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../navigation/custom_navigation.dart';
import '../app/core/utils/color_resources.dart';
import '../app/localization/localization/language_constant.dart';
import '../components/custom_button.dart';

class DateTimePicker extends StatefulWidget {
  final String? initialString;
  final String? format;
  final bool? isNotEmptyValue;
  final DateTime? startDateTime;
  final DateTime? minDateTime;
  final ValueChanged<DateTime>? valueChanged;
  final String label;
  final CupertinoDatePickerMode? mode;

  const DateTimePicker(
      {Key? key,
      this.mode,
      this.initialString,
      this.minDateTime,
      this.format,
      required this.valueChanged,
      this.isNotEmptyValue = false,
      this.startDateTime,
      required this.label})
      : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? date;

  @override
  void initState() {
    setState(() {
      if (widget.isNotEmptyValue!) {
        date = DateTime.parse(widget.initialString!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.h,
      width: context.width,
      decoration: const BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                height: 5.h,
                width: 36.w,
                decoration: BoxDecoration(
                    color: const Color(0xFF3C3C43).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(100)),
                child: const SizedBox(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: CupertinoDatePicker(
                mode: widget.mode ?? CupertinoDatePickerMode.date,
                onDateTimeChanged: (v) => date = v,
                initialDateTime: date ?? widget.startDateTime ?? DateTime.now(),
                minimumDate: widget.minDateTime != null
                    ? DateTime(widget.minDateTime!.year,
                        widget.minDateTime!.month, widget.minDateTime!.day)
                    : widget.startDateTime != null
                        ? DateTime(
                            widget.startDateTime!.year,
                            widget.startDateTime!.month,
                            widget.startDateTime!.day)
                        : DateTime(1900),
                maximumDate: DateTime(2100),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: CustomButton(
                text: getTranslated('confirm', context),
                onTap: () {
                  if (date != null) {
                    widget.valueChanged!(date!);
                    CustomNavigator.pop();
                  } else {
                    widget
                        .valueChanged!(widget.startDateTime ?? DateTime.now());
                    CustomNavigator.pop();
                  }
                },
                backgroundColor: Styles.PRIMARY_COLOR,
                textColor: Styles.WHITE_COLOR,
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
