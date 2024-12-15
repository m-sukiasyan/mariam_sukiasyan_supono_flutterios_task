import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/custom_colors.dart';
import '../utils/text_style_theme.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  final double progress;

  const CircularProgressIndicatorWidget({Key? key, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          width: 44.w,
          height: 44.h,
          child: CircularProgressIndicator(
            value: 1.0,
            backgroundColor: Colors.transparent,
            valueColor: const AlwaysStoppedAnimation<Color>(
                CustomColors.color959595),
            strokeWidth: 1.w,
          ),
        ),
        SizedBox(
          width: 44.w,
          height: 44.h,
          child: CircularProgressIndicator(
            value: progress,
            backgroundColor: Colors.transparent,
            valueColor: const AlwaysStoppedAnimation<Color>(
                CustomColors.colorWhite),
            strokeWidth: 1.w,
          ),
        ),
        Text(
          "${(progress * 100).toInt()}%",
          style: TextStyleTheme.instance.getStyle(
            TextStyleTheme.latoW400S16,
            CustomColors.color959595,
          ),
        ),
      ],
    );
  }
}
