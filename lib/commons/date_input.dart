import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/utils/formattingDate.dart';

typedef DateChaged = Function(DateTime? value);

class DateInput extends StatefulWidget {
  const DateInput(
      {super.key,
      required this.onChange,
      this.initalDate,
      this.firstDate,
      this.label,
      this.lastDate});
  final DateTime? initalDate;
  final String? label;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateChaged onChange;
  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  Future<void> showDatePickerHandler({required BuildContext context}) async {
    await showDatePicker(
            context: context,
            initialDate: widget.initalDate ?? DateTime.now(),
            firstDate: widget.firstDate ?? DateTime(2000),
            lastDate: widget.lastDate ?? DateTime(9999))
        .then((value) => widget.onChange(value));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.label}",
          style: textTheme().bodySmall?.copyWith(fontSize: 14.0),
        ),
        SizedBox(
          height: 2.h,
        ),
        TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
                backgroundColor: MaterialStatePropertyAll(Colors.grey.shade300),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: horizontalPadding / 2))),
            onPressed: () => showDatePickerHandler(context: context),
            child: Row(
              children: [
                Icon(Icons.date_range),
                SizedBox(
                  width: horizontalPadding / 8,
                ),
                Text(
                  widget.initalDate == null
                      ? '${widget.label}'
                      : formattingDate(date: widget.initalDate),
                  style: textTheme().bodySmall,
                )
              ],
            )),
      ],
    );
  }
}
