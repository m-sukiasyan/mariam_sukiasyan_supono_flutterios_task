import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../core/custom_widgets/custom_single_button.dart';
import '../../../core/utils/custom_colors.dart';
import '../../../core/utils/text_style_theme.dart';

class BottomContainerWidget extends StatefulWidget {
  final Function? onPressed;

  const BottomContainerWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  BottomContainerWidgetState createState() => BottomContainerWidgetState();
}
class BottomContainerWidgetState extends State<BottomContainerWidget> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 291.h,
        padding: EdgeInsets.only(
          left: 25.w,
          right: 25.w,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
          color: CustomColors.colorBlack,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Gap(30.h),
                  Text(
                    AppLocalizations.of(context)!.areYouReadyForYourTest,
                    textAlign: TextAlign.center,
                    style: TextStyleTheme.instance.getStyle(
                      TextStyleTheme.latoBoldW800S25,
                      CustomColors.colorWhite,
                    ),
                  ),
                  Gap(11.h),
                  Text(
                    AppLocalizations.of(context)!
                        .startNowByCreatingYourProfileAndConnect,
                    textAlign: TextAlign.center,
                    style: TextStyleTheme.instance.getStyle(
                      TextStyleTheme.latoW400S16,
                      CustomColors.color959595,
                    ),
                  ),
                ],
              ),
            ),
            Gap(15.h),
            CustomSingleButton(
              onPressed: () {
                if (widget.onPressed != null) {
                  widget.onPressed!();
                }
              },
              label: AppLocalizations.of(context)!.continueTxt,
            ),
            Gap(35.h),
          ],
        ),
      ),
    );
  }
}
