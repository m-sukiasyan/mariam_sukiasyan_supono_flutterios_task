import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/core/utils/text_style_theme.dart';

import '../utils/custom_colors.dart';

class CustomSingleButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final double? width;
  final double? height;
  final Color? buttonColor;
  final Color? textColor;

  const CustomSingleButton({super.key,
    required this.onPressed,
    required this.label,
    this.width,
    this.height,
    this.buttonColor,
    this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed != null
          ? () {
        onPressed!();
      } : null,
      child: Container(
        height: height ?? 50.h,
        padding: EdgeInsets.only(left: 25.w, right: 25),
        decoration: BoxDecoration(
          color: buttonColor ?? CustomColors.colorWhite,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
          child: Text(
              label,
              style: TextStyleTheme.instance.getStyle(
                  TextStyleTheme.latoW700S17,
                  CustomColors.colorBlack)
          ),
        ),
      ),
    );
  }
}
