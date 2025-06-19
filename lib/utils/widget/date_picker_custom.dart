import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/widget/text_style.dart';

class DatePickerCustom extends StatefulWidget {
  final String? restorationId;
  final RestorableDateTime selectedDate;
  final Function(DateTime?) selectDate;

  const DatePickerCustom({
    super.key,
    required this.restorationId,
    required this.selectDate,
    required this.selectedDate
  });

  @override
  State<DatePickerCustom> createState() => _DatePickerCustomState();
}

class _DatePickerCustomState extends State<DatePickerCustom>
    with RestorationMixin {
  // final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: widget.selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: widget.selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2025),
          lastDate: DateTime(2030),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        splashColor: ColorName.bacgroundRedIcon,
        onTap: () {
          print("date");
          _restorableDatePickerRouteFuture.present();
        },
        child: Container(
          height: 60.h,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextStyles.body2(
                  text: widget.selectedDate.value.toString().isEmpty
                      ? "Add attachment"
                      : DateFormat("MMMM dd, yyyy HH:ss")
                          .format(widget.selectedDate.value)
                          .toString(),
                  color: ColorName.textGrey),
              SizedBox(
                width: 10.w,
              ),
              Icon(
                Icons.date_range_outlined,
                color: Colors.grey,
                size: 24.sp,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement restorationId
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(widget.selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        widget.selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${widget.selectedDate.value.day}/${widget.selectedDate.value.month}/${widget.selectedDate.value.year}'),
        ));
      });
    }
  }
}
