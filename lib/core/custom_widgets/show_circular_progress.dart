import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/custom_colors.dart';

class ShowCircularProgress extends StatelessWidget {
  final String? message;

  const ShowCircularProgress({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: Colors.transparent,
      child: Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Material(
            elevation: 9,
            child: Container(
              color: Colors.white,
              width: 270,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: CustomColors.colorWhite,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(message != null
                        ? message!
                        : AppLocalizations
                        .of(context)
                        ?.pleaseWait ??
                        "Please wait",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
