import 'package:flutter/material.dart';

enum Environment { staging, prod }

class AppConfig extends InheritedWidget {
  final Environment environment;
  final String appTitle;
  final String baseUrl;

  const AppConfig({
    Key? key,
    required Widget child,
    required this.environment,
    required this.appTitle,
    required this.baseUrl,
  }) : super(key: key, child: child);

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
