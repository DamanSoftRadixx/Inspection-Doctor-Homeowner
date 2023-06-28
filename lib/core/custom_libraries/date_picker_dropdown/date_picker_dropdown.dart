// ignore_for_file: non_constant_identifier_names

library datepicker_dropdown;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

/// Defines widgets which are to used as DropDown Date Picker.
// ignore: must_be_immutable
class DatePickerDropdown extends StatefulWidget {
  ///DropDown select text style
  final TextStyle? textStyle;

  ///DropDown container box decoration
  final BoxDecoration? boxDecoration;

  ///InputDecoration for DropDown
  final InputDecoration? inputDecoration;

  ///DropDown expand icon
  final Icon? icon;

  ///Start year for date picker
  ///Default is 1900
  final int? startYear;

  ///End year for date picker
  ///Default is Current year
  final int? endYear;

  ///width between each drop down
  ///Default is 12.0
  final double width;

  ///Return selected date
  ValueChanged<String?>? onChangedDay;

  ///Return selected month
  ValueChanged<String?>? onChangedMonth;

  ///Return selected year
  ValueChanged<String?>? onChangedYear;

  ///Error message for Date
  String errorDay;

  ///Error message for Month
  String errorMonth;

  ///Error message for Year
  String errorYear;

  ///Hint for Month drop down
  ///Default is "Month"
  String hintMonth;

  ///Hint for Year drop down
  ///Default is "Year"
  String hintYear;

  ///Hint for Day drop down
  ///Default is "Day"
  String hintDay;

  ///Hint Textstyle for drop down
  TextStyle? hintTextStyle;

  ///Is Form validator enabled
  ///Default is false
  final bool isFormValidator;

  ///Is Expanded for dropdown
  ///Default is true
  final bool isExpanded;

  ///Selected Day between 1 to 31
  final int? selectedDay;

  ///Selected Month between 1 to 12
  final int? selectedMonth;

  ///Selected Year between startYear and endYear
  final int? selectedYear;

  ///Default [isDropdownHideUnderline] = false. Wrap with DropdownHideUnderline for the dropdown to hide the underline.
  final bool isDropdownHideUnderline;

  /// locale
  ///
  /// default `en`
  ///
  /// support `zh_CN`
  ///
  /// support `it_IT`
  /// support fr_FR
  final String locale;

  /// default true
  bool showYear;
  bool showMonth;
  bool showDay;

  /// month expanded flex
  int monthFlex;

  /// day expanded flex
  int dayFlex;

  /// year expanded flex
  int yearFlex;

  bool isCheckMonthValidation;
  bool isCheckYearValidation;
  bool isCheckDayValidation;

  DatePickerDropdown(
      {Key? key,
      this.textStyle,
      this.boxDecoration,
      this.inputDecoration,
      this.icon,
      this.isCheckDayValidation = false,
      this.isCheckYearValidation = false,
      this.isCheckMonthValidation = false,
      this.startYear,
      this.endYear,
      this.width = 12.0,
      this.onChangedDay,
      this.onChangedMonth,
      this.onChangedYear,
      this.isDropdownHideUnderline = false,
      this.errorDay = 'Please select day',
      this.errorMonth = 'Please select month',
      this.errorYear = 'Please select year',
      this.hintMonth = 'Month',
      this.hintDay = 'Day',
      this.hintYear = 'Year',
      this.hintTextStyle,
      this.isFormValidator = false,
      this.isExpanded = true,
      this.selectedDay,
      this.selectedMonth,
      this.selectedYear,
      this.locale = 'en',
      this.showDay = true,
      this.showMonth = true,
      this.showYear = true,
      this.monthFlex = 2,
      this.dayFlex = 1,
      this.yearFlex = 2})
      : assert(["en", "zh_CN", "it_IT", "tr", 'fr_FR'].contains(locale)),
        super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DatePickerDropdownState createState() => _DatePickerDropdownState();
}

class _DatePickerDropdownState extends State<DatePickerDropdown> {
  var monthselVal = '';
  var dayselVal = '';
  var yearselVal = '';
  int daysIn = 32;
  late List listdates = [];
  late List listyears = [];
  late List<dynamic> listMonths = [];

  @override
  void initState() {
    super.initState();
    dayselVal = widget.selectedDay != null ? widget.selectedDay.toString() : '';
    monthselVal =
        widget.selectedMonth != null ? widget.selectedMonth.toString() : '';
    yearselVal =
        widget.selectedYear != null ? widget.selectedYear.toString() : '';
    listdates = Iterable<int>.generate(daysIn).skip(1).toList();
    listyears =
        Iterable<int>.generate((widget.endYear ?? DateTime.now().year) + 1)
            .skip(widget.startYear ?? 1900)
            .toList()
            .reversed
            .toList();

    if (widget.locale == "zh_CN") {
      listMonths = listMonths_zh_CN;
    } else if (widget.locale == "it_IT") {
      listMonths = listMonths_it_IT;
    } else if (widget.locale == "tr") {
      listMonths = listMonths_tr;
    } else if (widget.locale == "fr_FR") {
      listMonths = listMonths_fr_FR;
    } else {
      listMonths = listMonths_en;
    }
  }

  ///Month selection dropdown function
  monthSelected(value) {
    widget.onChangedMonth!(value);
    monthselVal = value;
    int days = daysInMonth(
        yearselVal == '' ? DateTime.now().year : int.parse(yearselVal),
        int.parse(value));
    listdates = Iterable<int>.generate(days + 1).skip(1).toList();
    checkDates(days);
    update();
  }

  ///check dates for selected month and year
  void checkDates(days) {
    if (dayselVal != '') {
      if (int.parse(dayselVal) > days) {
        dayselVal = '';
        widget.onChangedDay!('');
        update();
      }
    }
  }

  ///find days in month and year
  int daysInMonth(year, month) => DateTimeRange(
          start: DateTime(year, month, 1), end: DateTime(year, month + 1))
      .duration
      .inDays;

  ///day selection dropdown function
  daysSelected(value) {
    widget.onChangedDay!(value);
    dayselVal = value;
    update();
  }

  ///year selection dropdown function
  yearsSelected(value) {
    widget.onChangedYear!(value);
    yearselVal = value;
    if (monthselVal != '') {
      int days = daysInMonth(
          yearselVal == '' ? DateTime.now().year : int.parse(yearselVal),
          int.parse(monthselVal));
      listdates = Iterable<int>.generate(days + 1).skip(1).toList();
      checkDates(days);
      update();
    }
    update();
  }

  ///list of months , en
  List<dynamic> listMonths_en = [
    {"id": 1, "value": "January"},
    {"id": 2, "value": "February"},
    {"id": 3, "value": "March"},
    {"id": 4, "value": "April"},
    {"id": 5, "value": "May"},
    {"id": 6, "value": "June"},
    {"id": 7, "value": "July"},
    {"id": 8, "value": "August"},
    {"id": 9, "value": "September"},
    {"id": 10, "value": "October"},
    {"id": 11, "value": "November"},
    {"id": 12, "value": "December"}
  ];

  ///list of months , zh_CN
  List<dynamic> listMonths_zh_CN = [
    {"id": 1, "value": "1月"},
    {"id": 2, "value": "2月"},
    {"id": 3, "value": "3月"},
    {"id": 4, "value": "4月"},
    {"id": 5, "value": "5月"},
    {"id": 6, "value": "6月"},
    {"id": 7, "value": "7月"},
    {"id": 8, "value": "8月"},
    {"id": 9, "value": "9月"},
    {"id": 10, "value": "10月"},
    {"id": 11, "value": "11月"},
    {"id": 12, "value": "12月"}
  ];

  ///list of months , it_IT
  List<dynamic> listMonths_it_IT = [
    {"id": 1, "value": "Gennaio"},
    {"id": 2, "value": "Febbraio"},
    {"id": 3, "value": "Marzo"},
    {"id": 4, "value": "Aprile"},
    {"id": 5, "value": "Maggio"},
    {"id": 6, "value": "Giugno"},
    {"id": 7, "value": "Luglio"},
    {"id": 8, "value": "Agosto"},
    {"id": 9, "value": "Settembre"},
    {"id": 10, "value": "Ottobre"},
    {"id": 11, "value": "Novembre"},
    {"id": 12, "value": "Dicembre"}
  ];

  ///list of months , tr
  List<dynamic> listMonths_tr = [
    {"id": 1, "value": "Ocak"},
    {"id": 2, "value": "Şubat"},
    {"id": 3, "value": "Mart"},
    {"id": 4, "value": "Nisan"},
    {"id": 5, "value": "Mayıs"},
    {"id": 6, "value": "Haziran"},
    {"id": 7, "value": "Temmuz"},
    {"id": 8, "value": "Ağustos"},
    {"id": 9, "value": "Eylül"},
    {"id": 10, "value": "Ekim"},
    {"id": 11, "value": "Kasım"},
    {"id": 12, "value": "Aralık"}
  ];

  ///list of months , fr_FR
  List<dynamic> listMonths_fr_FR = [
    {"id": 1, "value": "Janvier"},
    {"id": 2, "value": "Fevrier"},
    {"id": 3, "value": "Mars"},
    {"id": 4, "value": "Avril"},
    {"id": 5, "value": "Mai"},
    {"id": 6, "value": "Juin"},
    {"id": 7, "value": "Juillet"},
    {"id": 8, "value": "Aout"},
    {"id": 9, "value": "Septembre"},
    {"id": 10, "value": "Octobre"},
    {"id": 11, "value": "Novembre"},
    {"id": 12, "value": "Décembre"}
  ];

  ///update function
  update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.showDay)
          Expanded(
            flex: widget.dayFlex,
            child: Container(
              decoration: widget.boxDecoration ?? const BoxDecoration(),
              child: SizedBox(
                  // height: 49,
                  child: ButtonTheme(
                alignedDropdown: true,
                child: widget.isDropdownHideUnderline
                    ? DropdownButtonHideUnderline(
                        child: dayDropdown(),
                      )
                    : dayDropdown(),
              )),
            ),
          ),
        if (widget.showDay) w(widget.width),
        if (widget.showMonth)
          Expanded(
            flex: widget.monthFlex,
            child: Container(
              decoration: widget.boxDecoration ?? const BoxDecoration(),
              child: SizedBox(
                // height: 49,
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: widget.isDropdownHideUnderline
                      ? DropdownButtonHideUnderline(
                          child: monthDropdown(),
                        )
                      : monthDropdown(),
                ),
              ),
            ),
          ),
        if (widget.showMonth) w(widget.width),
        if (widget.showYear)
          Expanded(
            flex: widget.yearFlex,
            child: Container(
              decoration: widget.boxDecoration ?? const BoxDecoration(),
              child: SizedBox(
                // height: 49,
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: widget.isDropdownHideUnderline
                      ? DropdownButtonHideUnderline(
                          child: yearDropdown(),
                        )
                      : yearDropdown(),
                ),
              ),
            ),
          ),
      ],
    );
  }

  ///month dropdown
  Widget monthDropdown() {
    return Container(
      height: 49.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
      decoration: BoxDecoration(
        color: lightColorPalette.whiteColorPrimary.shade900,
        border: Border.all(
          style: BorderStyle.solid,
          //strokeAlign: 1.h,
          color: widget.isCheckMonthValidation == false
              ? lightColorPalette.additionalSwatch1.shade800
              : lightColorPalette.redDark,
          width: 1.0.w,
        ),
        borderRadius: BorderRadius.all(Radius.circular(6.r)),
      ),
      child: DropdownButton2<String>(
        isDense: true,
        menuItemStyleData:
            MenuItemStyleData(padding: EdgeInsets.only(left: 0.w)),
        buttonStyleData: ButtonStyleData(padding: EdgeInsets.only(left: 5.w)),
        dropdownStyleData: DropdownStyleData(
            offset: const Offset(0, -18),
            elevation: 3,
            maxHeight: 300.h,
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: lightColorPalette.whiteColorPrimary.shade900,
            )),
        underline: const SizedBox(),
        isExpanded: true,
        /*  iconStyleData: IconStyleData(
          icon: Icon(Icons.arrow_drop_down,
              color: lightColorPalette.additionalSwatch1.shade900,
              size: 25.h)
              .paddingOnly(right: 4.w),
        ),*/
        hint: Text(widget.hintMonth, style: widget.hintTextStyle),
        value: monthselVal == '' ? null : monthselVal,
        items: listMonths.map((item) {
          return DropdownMenuItem<String>(
            value: item["id"].toString(),
            child: Text(item["value"].toString(),
                style: widget.textStyle ??
                    const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
          );
        }).toList(),
        onChanged: (value) {
          monthSelected(value);
        },
      ),
    );
  }

  ///Remove underline from dropdown
  InputDecoration removeUnderline() {
    return const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
  }

  ///year dropdown
  Widget yearDropdown() {
    return Container(
      height: 49.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
      decoration: BoxDecoration(
        color: lightColorPalette.whiteColorPrimary.shade900,
        border: Border.all(
          style: BorderStyle.solid,
          //strokeAlign: 1.h,
          color: widget.isCheckYearValidation == false
              ? lightColorPalette.additionalSwatch1.shade800
              : lightColorPalette.redDark,
          width: 1.0.w,
        ),
        borderRadius: BorderRadius.all(Radius.circular(6.r)),
      ),
      child: DropdownButton2<String>(
        isDense: true,
        isExpanded: true,
        menuItemStyleData:
            MenuItemStyleData(padding: EdgeInsets.only(left: 0.w)),
        buttonStyleData: ButtonStyleData(padding: EdgeInsets.only(left: 5.w)),
        dropdownStyleData: DropdownStyleData(
            offset: const Offset(0, -18),
            elevation: 3,
            maxHeight: 300.h,
            padding: EdgeInsets.only(left: 10.w, right: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: lightColorPalette.whiteColorPrimary.shade900,
            )),
        underline: const SizedBox(),
        /* iconStyleData: IconStyleData(
          icon: Icon(Icons.arrow_drop_down,
              color: lightColorPalette.additionalSwatch1.shade900,
              size: 25.h)
              .paddingOnly(right: 4.w),
        ),*/
        hint: Text(widget.hintYear, style: widget.hintTextStyle),
        value: yearselVal == '' ? null : yearselVal,
        items: listyears.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(item.toString(),
                style: widget.textStyle ??
                    const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
          );
        }).toList(),
        onChanged: (value) {
          yearsSelected(value);
        },
      ),
    );
  }

  ///day dropdown
  Widget dayDropdown() {
    return Container(
      height: 49.h,
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
      decoration: BoxDecoration(
        color: lightColorPalette.whiteColorPrimary.shade900,
        border: Border.all(
          style: BorderStyle.solid,
          //strokeAlign: 1.h,
          color: widget.isCheckDayValidation == false
              ? lightColorPalette.additionalSwatch1.shade800
              : lightColorPalette.redDark,
          width: 1.0.w,
        ),
        borderRadius: BorderRadius.all(Radius.circular(6.r)),
      ),
      child: DropdownButton2<String>(
        isDense: true,
        isExpanded: true,
        menuItemStyleData:
            MenuItemStyleData(padding: EdgeInsets.only(left: 0.w)),
        buttonStyleData: ButtonStyleData(padding: EdgeInsets.only(left: 5.w)),
        dropdownStyleData: DropdownStyleData(
            offset: const Offset(0, -18),
            elevation: 3,
            maxHeight: 300.h,
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: lightColorPalette.whiteColorPrimary.shade900,
            )),
        underline: const SizedBox(),
        /*  iconStyleData: IconStyleData(
          icon: Icon(Icons.arrow_drop_down,
              color: lightColorPalette.additionalSwatch1.shade900,
              size: 25.h)
              .paddingOnly(right: 4.w),
        ),*/
        hint: Text(widget.hintDay, style: widget.hintTextStyle),
        value: dayselVal == '' ? null : dayselVal,
        items: listdates.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(item.toString(),
                style: widget.textStyle ??
                    const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
          );
        }).toList(),
        onChanged: (value) {
          daysSelected(value);
        },
      ),
    );
  }

  ///sizedbox for width
  Widget w(double count) => SizedBox(
        width: count,
      );
}
