import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_screen_widgets/pass_info_date_field_widget.dart';

import '../../../core/utils/custom_colors.dart';
import '../../../core/utils/text_style_theme.dart';

class PassInfoBirthdayStepWidget extends StatefulWidget {
  final Function(String day, String month, String year) onDateEntered;

  const PassInfoBirthdayStepWidget({
    Key? key,
    required this.onDateEntered,
  }) : super(key: key);

  @override
  _PassInfoBirthdayStepWidgetState createState() =>
      _PassInfoBirthdayStepWidgetState();
}

class _PassInfoBirthdayStepWidgetState
    extends State<PassInfoBirthdayStepWidget> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final FocusNode _dayFocusNode = FocusNode();
  final FocusNode _monthFocusNode = FocusNode();
  final FocusNode _yearFocusNode = FocusNode();


  bool _isValidDay(String value) =>
      int.tryParse(value) != null && int.parse(value) >= 1 &&
          int.parse(value) <= 31;

  bool _isValidMonth(String value) =>
      int.tryParse(value) != null && int.parse(value) >= 1 &&
          int.parse(value) <= 12;

  bool _isValidYear(String value) {
    final currentYear = DateTime
        .now()
        .year;
    return int.tryParse(value) != null &&
        int.parse(value) >= 1900 &&
        int.parse(value) <= currentYear;
  }

  bool _isDateValid() {
    return _isValidDay(_dayController.text) &&
        _isValidMonth(_monthController.text) &&
        _isValidYear(_yearController.text);
  }

  void _onFieldChange() {
    if (_isDateValid()) {
      widget.onDateEntered(
        _dayController.text,
        _monthController.text,
        _yearController.text,
      );
    } else {
      widget.onDateEntered('', '', '');
    }
  }

  @override
  void initState() {
    super.initState();
    _dayController.addListener(_onFieldChange);
    _monthController.addListener(_onFieldChange);
    _yearController.addListener(_onFieldChange);
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _dayFocusNode.dispose();
    _monthFocusNode.dispose();
    _yearFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 25.w, right: 25.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.whensYourBirthday,
              style: TextStyleTheme.instance.getStyle(
                TextStyleTheme.latoBoldW800S30,
                CustomColors.colorWhite,
              ),
            ),
            Gap(58.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PassInfoDateFieldWidget(controller: _dayController,
                    currentFocus: _dayFocusNode,
                    nextFocus: _monthFocusNode,
                    previousFocus: null,
                    label: AppLocalizations.of(context)!.day,
                    maxLength: 2),
                Gap(20.w),
                PassInfoDateFieldWidget(controller: _monthController,
                    currentFocus: _monthFocusNode,
                    nextFocus: _yearFocusNode,
                    previousFocus: _dayFocusNode,
                    label: AppLocalizations.of(context)!.month,
                    maxLength: 2),
                Gap(20.w),
                PassInfoDateFieldWidget(controller: _yearController,
                    currentFocus: _yearFocusNode,
                    nextFocus: null,
                    previousFocus: _monthFocusNode,
                    label: AppLocalizations.of(context)!.year,
                    maxLength: 4),
              ],
            ),
          ],
        )
    );
  }
}
