import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/core/di/injection_dependencies.dart' as get_it;

import 'config/app_config.dart';
import 'main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await get_it.initializeDependencies();
  AppConfig configuredApp = AppConfig(
    environment: Environment.prod,
    appTitle: "Task",
    baseUrl: "",
    child: const MainApp(),
  );
  runApp(configuredApp);
}
