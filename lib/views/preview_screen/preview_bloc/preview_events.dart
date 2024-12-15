
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../data/database/init_database/entities/user_entity.dart';

class PreviewEvents {
  const PreviewEvents();
}

class SaveUserEvent extends PreviewEvents {
  final String base64Photo;
  final UserEntity? userEntity;

  const SaveUserEvent(this.base64Photo, this.userEntity);
}

class UpdateAdBannerEvent extends PreviewEvents {
  BannerAd? bannerAd;

  UpdateAdBannerEvent(this.bannerAd);
}

