import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/core/utils/custom_colors.dart';

import '../../../core/utils/text_style_theme.dart';

class PassInfoDateFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final FocusNode? previousFocus;
  final String label;
  final int maxLength;

  const PassInfoDateFieldWidget({
    Key? key,
    required this.controller,
    required this.currentFocus,
    required this.previousFocus,
    this.nextFocus,
    required this.label,
    required this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: CustomColors.color959595,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: TextField(
            controller: controller,
            focusNode: currentFocus,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: TextStyleTheme.instance.getStyle(
              TextStyleTheme.latoBoldW800S25,
              CustomColors.colorWhite,
            ),
            decoration: InputDecoration(
              hintText: '-',
              border: InputBorder.none,
              hintStyle: TextStyleTheme.instance.getStyle(
                TextStyleTheme.latoBoldW800S25,
                CustomColors.colorWhite,
              ),
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                if (previousFocus != null) {
                  FocusScope.of(context).requestFocus(previousFocus);
                } else {
                  currentFocus.unfocus();
                }
              } else if (value.length == maxLength) {
                if (nextFocus != null) {
                  FocusScope.of(context).requestFocus(nextFocus);
                } else {
                  currentFocus.unfocus();
                }
              }
            },
          ),
        ),
        Gap(4.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyleTheme.instance.getStyle(
            TextStyleTheme.latoW400S16,
            CustomColors.color959595,
          ),
        ),
      ],
    );
  }
}
