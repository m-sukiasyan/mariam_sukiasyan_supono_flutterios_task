import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../core/utils/nullable.dart';

enum PreviewStatesEnum { initial, loading, loaded, bannerAddUpdated, error}

class PreviewStates {
  final PreviewStatesEnum previewStatesEnum;
  final String? errorMessage;
  BannerAd? bannerAd;

  PreviewStates({
    this.previewStatesEnum = PreviewStatesEnum.initial,
    this.bannerAd,
    this.errorMessage});

  PreviewStates copyWith({
    required PreviewStatesEnum previewStatesEnum,
    BannerAd? bannerAd,
    Nullable<BannerAd>? nullableBannerAd,
    String? errorMessage}) {
    return PreviewStates(
      previewStatesEnum: previewStatesEnum,
      bannerAd: nullableBannerAd != null
          ? nullableBannerAd.value
          : bannerAd ?? this.bannerAd,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
