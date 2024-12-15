import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/custom_colors.dart';
import '../../../core/utils/text_style_theme.dart';

class PassInfoNicknameStepWidget extends StatelessWidget {
  final TextEditingController nicknameController;
  final Function(String nickname) onNicknameChanged;

  const PassInfoNicknameStepWidget({
    Key? key,
    required this.nicknameController,
    required this.onNicknameChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.only(left: 25.w, right: 25.w),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.chooseYourNickname,
          style: TextStyleTheme.instance.getStyle(
            TextStyleTheme.latoBoldW800S30,
            CustomColors.colorWhite,
          ),
        ),
        Gap(58.h),
        TextField(
          controller: nicknameController,
          onChanged: (value) {
            onNicknameChanged(value); // Update nickname in UserEntity
          },
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.pleaseEnterYourFullName,
            hintStyle: TextStyleTheme.instance.getStyle(
              TextStyleTheme.latoW400S16,
              CustomColors.color959595,
            ),
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: CustomColors.color959595,
                width: 1.5, // Set the border width
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: CustomColors.color959595,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: CustomColors.color959595,
                width: 2.0,
              ),
            ),
          ),
          style: TextStyleTheme.instance.getStyle(
            TextStyleTheme.latoBoldW800S25,
            CustomColors.colorWhite,
          ),
        ),
      ],
    )
    );
  }
}
