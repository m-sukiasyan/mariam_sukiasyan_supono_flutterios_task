import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/core/custom_widgets/custom_single_button.dart';

import '../../../core/utils/custom_colors.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/text_style_theme.dart';
import '../../../data/models/photo_instructions_model.dart';

class PassInfoPhotoStepWidget extends StatelessWidget {
  final VoidCallback onPhotoButtonPressed;
  final PhotoInstructionsModel instructionsModel;

  const PassInfoPhotoStepWidget({
    Key? key,
    required this.onPhotoButtonPressed,
    required this.instructionsModel,
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
          AppLocalizations.of(context)!.addANicePhotoOfYourself,
          style: TextStyleTheme.instance.getStyle(
            TextStyleTheme.latoBoldW800S30,
            CustomColors.colorWhite,
          ),
        ),
        Gap(58.h),
        CustomSingleButton(
            onPressed: onPhotoButtonPressed,
            label: AppLocalizations.of(context)!.takeYourFirstPhoto),
        Gap(50.h),
        if (instructionsModel.instructions != null &&
            instructionsModel.instructions!.isNotEmpty)
          Container(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: CustomColors.color959595,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20.h),
                Text(
                  AppLocalizations.of(context)!.makeSureThatYourImage,
                  style: TextStyleTheme.instance.getStyle(
                    TextStyleTheme.latoBoldW800S20,
                    CustomColors.colorWhite,
                  ),
                ),
                Gap(10.h),
                ...instructionsModel.instructions!.map((instruction) {
                  return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.icCheckSVG,
                            height: 10.h,
                            width: 13.w,
                            fit: BoxFit.scaleDown),
                        Gap(8.w),
                        Expanded(
                          child: Text(
                            instruction,
                            style: TextStyleTheme.instance.getStyle(
                              TextStyleTheme.latoW500S16,
                              CustomColors.color959595,
                            ),
                          ),
                        ),
                      ],
                  );
                }),
                Gap(20.h),
              ],
            ),
          ),
      ],
    )
    );
  }
}
