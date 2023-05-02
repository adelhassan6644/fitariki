import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../navigation/custom_navigation.dart';
import '../main_widgets/confirm_bottom_sheet.dart';


class DateTimePicker extends StatefulWidget {
  final String? initialString;
  final String? format;
  final bool? isNotEmptyValue;
  final DateTime? startDateTime;
  final ValueChanged<DateTime>? valueChanged;
  final String label;

  const DateTimePicker(
      {Key? key,
        this.initialString,
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
  String _date = "";
  DateTime? date;

  @override
  void initState() {
    _date = widget.initialString ?? widget.label;
    if (widget.isNotEmptyValue!) {
      date = DateTime.parse(widget.initialString!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet.show(
        label: widget.label,
        height: 360,
        onConfirm: () {
          if (date != null) {
            setState(() =>
            _date = DateFormat(widget.format??"dd,MMM,yyyy").format(date!));
            widget.valueChanged!(date!);
            CustomNavigator.pop();
          } else {
            setState(() => _date =
                DateFormat(widget.format??"dd,MMM,yyyy").format(DateTime.now()));
            widget.valueChanged!(DateTime.now());
            CustomNavigator.pop();
          }
        },
        list: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) => date = value,
            initialDateTime: date ?? widget.startDateTime ?? DateTime.now(),
            minimumDate: widget.startDateTime != null ? DateTime(
                widget.startDateTime!.year,
                widget.startDateTime!.month,
                widget.startDateTime!.day)
                : DateTime(1900),
            maximumDate: DateTime(2100)));
  }
}