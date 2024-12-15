import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  NavigatorState get _navigator => Navigator.of(this);

  void popNavigator(Widget screenToNavigate,
      {Map<dynamic, dynamic>? returnValue}) {
    if (_navigator.canPop()) {
      _navigator.pop(returnValue);
    } else {
      _navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => screenToNavigate),
              (Route<dynamic> route) => false);
    }
  }

  void pushNavigator(Widget screenToNavigate, {Function(dynamic)? callback}) {
    _navigator
        .push(MaterialPageRoute(builder: (context) => screenToNavigate))
        .then((value) {
      if (callback != null) {
        callback(value);
      }
    });
  }

  void pushWithReplaceNavigator(Widget screenToNavigate,
      {Function(dynamic)? callback}) {
    _navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => screenToNavigate));
  }

  void pushWithRemoveUntilNavigator(Widget screenToNavigate,
      {Function(dynamic)? callback}) {
    _navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screenToNavigate),
            (Route<dynamic> route) => false);
  }
}
