import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:mariam_sukiasyan_supono_flutterios_task/views/camera_screen/camera_screen.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/on_boarding_screen/on_boarding_screen.dart';
import 'config/app_config.dart';
import 'core/custom_widgets/custom_scaffold.dart';
import 'core/enums/page_state_enum.dart';
import 'core/enums/passed_info_status_enum.dart';
import 'core/utils/custom_colors.dart';
import 'data/database/init_database/entities/user_entity.dart';

class MainApp extends StatefulWidget {
  static final GlobalKey<_MainAppState> globalKey = GlobalKey<_MainAppState>(); // Define global key

  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  PageState? _pageState = PageState.loading;

  PassedInfoStatusEnum _passedInfoStatusEnum = PassedInfoStatusEnum.notPassed;
  Locale? _locale;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<void> _init() async {
    await Future.delayed(Duration.zero, () async {
      await _checkIfUserAlreadyPassedInfo();
    });
  }

  Future<void> _checkIfUserAlreadyPassedInfo() async {
    UserEntity? userEntity = await UserEntity.myProfile;
    _passedInfoStatusEnum =
    userEntity != null ? PassedInfoStatusEnum.passed : PassedInfoStatusEnum
        .notPassed;
    setState(() {
      _pageState = PageState.loaded;
    });
  }


  Locale getTheLocale(BuildContext context, List<Locale>? locales) {
    return const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          title: AppConfig.of(context)!.appTitle,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
            ColorScheme.fromSeed(seedColor: CustomColors.colorWhite),
            useMaterial3: false,
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          locale: _locale,
          supportedLocales: const [
            Locale('en', ''),
          ],
          localeListResolutionCallback: (locales, supportedLocales) {
            return getTheLocale(context, locales);
          },
          builder: (context, child) =>
              MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  boldText: false,
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: child!,
              ),
          home: CustomScaffold(
            pageState: _pageState ?? PageState.loaded,
            builder: (context) => _whichWidget(),
          ),
        );
      },
    );
  }

  Widget _whichWidget() {
    return _passedInfoStatusEnum == PassedInfoStatusEnum.passed
        ? CameraScreen()
        : OnboardingScreen();
  }
}
