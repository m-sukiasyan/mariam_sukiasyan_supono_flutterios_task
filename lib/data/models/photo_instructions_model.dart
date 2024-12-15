import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhotoInstructionsModel {
  final List<String>? instructions;

  PhotoInstructionsModel({this.instructions});

  factory PhotoInstructionsModel.defaultInstructions(BuildContext context) {
    return PhotoInstructionsModel(
      instructions: [
        AppLocalizations.of(context)!.showsYourFaceClearly,
        AppLocalizations.of(context)!.yourselfOnlyNoGroupPic,
        AppLocalizations.of(context)!.noFakePicObjectOrSomeoneElse,
      ],
    );
  }
}
