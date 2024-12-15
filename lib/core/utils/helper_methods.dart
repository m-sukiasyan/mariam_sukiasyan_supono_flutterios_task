import 'dart:convert';
import 'dart:io';

import '../enums/pass_info_step_enum.dart';
import 'images.dart';

class HelperMethods {
  static Future<String> convertImageToBase64(String imagePath) async {
    final bytes = await File(imagePath).readAsBytes();
    return base64Encode(bytes);
  }

  static String getBackgroundImage(PassInfoStepEnum step) {
    switch (step) {
      case PassInfoStepEnum.birthday:
        return Images.bg1PNG;
      case PassInfoStepEnum.nickname:
        return Images.bg2PNG;
      case PassInfoStepEnum.gender:
        return Images.bg3PNG;
      case PassInfoStepEnum.photo:
        return Images.bg4PNG;
    }
  }
}
