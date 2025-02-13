import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final String? hintText;
  final Function(DateTime) onDateSelected;
  final DateTime? initialDate;
  final String? Function(String?)? validator;

  const CustomDatePicker({
    super.key,
    this.hintText,
    required this.onDateSelected,
    this.initialDate,
    this.validator,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDay;
  late TextEditingController _dateController;

  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDate ?? DateTime.now();
    _dateController = TextEditingController(
      text: widget.initialDate != null
          ? dateFormat.format(widget.initialDate!)
          : '',
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 12.sp),
      controller: _dateController,
      onTap: () {
        _selectDate(context, _selectedDay, _dateController);
      },
      readOnly: true,
      validator: widget.validator,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.date_range_outlined,
          size: 18.w,
          color: AppColors.groceryRatingGray.withOpacity(0.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        fillColor: AppColors.groceryWhite,
        filled: true,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.nunito(
          textStyle: TextStyle(
            color: AppColors.groceryRatingGray,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
              color: AppColors.groceryRatingGray.withOpacity(0.2), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.groceryRatingGray.withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4.r),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
            color: AppColors.grocerySecondary.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
            color: AppColors.grocerySecondary.withOpacity(0.5),
            width: 1,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      keyboardType: TextInputType.number,
    );
  }

  Future<void> _selectDate(BuildContext context, DateTime selectedDate,
      TextEditingController controller) async {
    final DateTime? picked = await showRoundedDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.utc(2020, 1, 1),
      lastDate: DateTime.utc(2030, 12, 31),
      borderRadius: 12,
      height: MediaQuery.of(context).size.height * 0.35,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: AppColors.groceryPrimary),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        textStyleYearButton: const TextStyle(
          color: AppColors.groceryWhite,
          fontSize: 20,
        ),
        textStyleDayButton: GoogleFonts.nunito(
          textStyle: const TextStyle(
            color: AppColors.groceryWhite,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        paddingDatePicker: const EdgeInsets.all(10),
        textStyleButtonPositive: const TextStyle(
            color: AppColors.groceryPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        textStyleButtonNegative: GoogleFonts.nunito(
          textStyle: const TextStyle(
            color: AppColors.groceryPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundHeader: AppColors.groceryPrimary,
        textStyleButtonAction: const TextStyle(
          color: AppColors.groceryWhite,
          fontSize: 18,
        ),
        textStyleCurrentDayOnCalendar: const TextStyle(
          color: AppColors.groceryPrimary,
          fontSize: 16,
        ),
        textStyleDayOnCalendarSelected: GoogleFonts.nunito(
          textStyle: const TextStyle(
            color: AppColors.groceryWhite,
            fontSize: 16,
          ),
        ),
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        _selectedDay = picked;
        widget.onDateSelected(picked);
        controller.text = dateFormat.format(picked);
      });
    }
  }
}
