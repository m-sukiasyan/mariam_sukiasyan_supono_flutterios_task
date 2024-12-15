import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/custom_colors.dart';
import '../../../core/utils/text_style_theme.dart';
import '../../../data/models/gender_options_model.dart';

class PassInfoGenderStepWidget extends StatelessWidget {
  final String? selectedGender;
  final GenderOptionsModel genderOptionsModel;
  final Function(String) onGenderSelected;

  PassInfoGenderStepWidget({
    Key? key,
    required this.selectedGender,
    required this.genderOptionsModel,
    required this.onGenderSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 25.w, right: 25.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.whichGenderDoYouIdentifyAs,
              style: TextStyleTheme.instance.getStyle(
                TextStyleTheme.latoBoldW800S30,
                CustomColors.colorWhite,
              ),
            ),
            Text(
              AppLocalizations.of(context)!
                  .yourGenderHelpsUsFindTheRightMatchesForYou,
              textAlign: TextAlign.left,
              style: TextStyleTheme.instance.getStyle(
                TextStyleTheme.latoW400S16,
                CustomColors.color959595,
              ),
            ),
            Gap(40.h),
            ...?genderOptionsModel.genderOptions?.map((gender) {
              final isSelected = selectedGender == gender;
              return GestureDetector(
                onTap: () => onGenderSelected(gender),
                child: Container(
                  margin: EdgeInsets.only(bottom: 25.h),
                  height: 67.h,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? CustomColors.colorWhite.withValues(alpha: 0.25)
                        : CustomColors.colorBlack.withValues(alpha: 0.25),
                    border: Border.all(
                      color: CustomColors.color959595,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  alignment: Alignment.center,
                  // Center the text inside the container
                  child: Text(
                    gender,
                    style: TextStyleTheme.instance.getStyle(
                      TextStyleTheme.latoBoldW800S23,
                      CustomColors.colorWhite,
                    ),
                  ),
                ),
              );
            }),
          ],
        )
    );
  }
}
