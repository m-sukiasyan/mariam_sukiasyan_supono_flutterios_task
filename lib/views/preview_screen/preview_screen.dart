import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/core/utils/helper_methods.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/core/utils/navigator_extension.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/data/database/init_database/entities/user_entity.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/preview_screen/preview_bloc/preview_bloc.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/preview_screen/preview_bloc/preview_events.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/preview_screen/preview_bloc/preview_states.dart';
import '../../core/custom_widgets/show_circular_progress.dart';
import '../../core/di/injection_dependencies.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/custom_colors.dart';
import '../../core/utils/images.dart';
import '../../core/utils/text_style_theme.dart';
import '../../data/secure_storage/secure_storage.dart';
import '../settings_screen/settings_screen.dart';

class PreviewScreen extends StatefulWidget {
  final UserEntity? userEntity;
  final String imagePath;

  const PreviewScreen({
    super.key,
    required this.userEntity,
    required this.imagePath,
  });

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> with WidgetsBindingObserver {
  final PreviewBloc _previewBloc = getIt<PreviewBloc>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    loadAd();

    _saveUserPhoto();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _previewBloc.state.bannerAd?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      _checkUnlockStatus();
    }
  }

  Future<void> _checkUnlockStatus() async {
    bool isUnlocked = await isAppUnlocked();

    if (isUnlocked) {
      _previewBloc.add(UpdateAdBannerEvent(null));
    } else {
      loadAd();
    }
  }

  Future<void> _saveUserPhoto() async {
    final base64Photo = await HelperMethods.convertImageToBase64(
        widget.imagePath);
    _previewBloc.add(
        SaveUserEvent(base64Photo, widget.userEntity));
  }

  Future<void> loadAd() async {
    bool isUnlocked = await isAppUnlocked();

    if (isUnlocked) return;

    if (_previewBloc.state.bannerAd != null) return;

    BannerAd bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? Constants.testAdUnitIdAndroid
          : Constants.testAdUnitIdIOS,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => setState(() {}),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('Ad failed to load: $error');
          ad.dispose();
        },
      ),
    );

    _previewBloc.add(UpdateAdBannerEvent(bannerAd));
  }

  Future<bool> isAppUnlocked() async {
    return await SecureStorage.readUnlockData() ?? false;
  }

  void _init(BuildContext providerContext) async {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _previewBloc,
      child: BlocConsumer<PreviewBloc, PreviewStates>(
        listener: (context, state) {
          if (state.previewStatesEnum == PreviewStatesEnum.bannerAddUpdated) {
            if (state.bannerAd != null) {
              state.bannerAd?.load();
            } else {
              state.bannerAd?.dispose();
            }
          }
        },
        builder: (providerContext, state) {
          return _buildViewPerState(state, providerContext);
        },
      ),
    );
  }

  Widget _buildViewPerState(PreviewStates states,
      BuildContext providerContext) {
    if (states.previewStatesEnum == PreviewStatesEnum.initial) {
      _init(providerContext);
    } else if (states.previewStatesEnum == PreviewStatesEnum.loading) {
      return Stack(
        children: [
          _buildView(),
          const ShowCircularProgress(),
        ],
      );
    }
    return _buildView();
  }

  Widget _buildView() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.file(
            File(widget.imagePath),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
              top: 59.h,
              left: 25.w,
              right: 25.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      child: SvgPicture.asset(
                        Images.icBackSVG,
                        width: 44.w,
                        height: 44.h,
                      ),
                      onTap: () =>
                      {
                        if (Navigator.canPop(context))
                          Navigator.pop(context),
                      }
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNavigator(SettingsScreen(
                        returnFunction: () {
                          _checkUnlockStatus();
                          Navigator.pop(context);
                        },
                      ));
                    },
                    child: SvgPicture.asset(Images.icSettingSVG,
                      width: 44.w,
                      height: 44.h,
                    ),
                  ),
                ],
              )
          ),
          if (_previewBloc.state.bannerAd != null)
            Positioned(
                bottom: 30,
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: _previewBloc.state.bannerAd!.size.height.toDouble() +
                      25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _previewBloc.add(UpdateAdBannerEvent(null));
                        },
                        child: Image.asset(
                          Images.icRedClosePNG,
                          width: 72.w,
                          height: 22.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 1,
                        color: Colors.red,
                      ),
                      Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: _previewBloc.state.bannerAd!.size.height
                              .toDouble(),
                          color: CustomColors.colorBlack,
                          child:
                          AdWidget(ad: _previewBloc.state.bannerAd!)
                      )
                    ],
                  ),
                )
            )
        ],
      ),
    );
  }
}
