import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderOptionsModel {
  final List<String>? genderOptions;

  GenderOptionsModel({this.genderOptions});

  factory GenderOptionsModel.defaultOptions(BuildContext context) {
    return GenderOptionsModel(
      genderOptions: [
        AppLocalizations.of(context)!.male,
        AppLocalizations.of(context)!.female,
        AppLocalizations.of(context)!.other
      ],
    );
  }
}
