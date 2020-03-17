import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nkust_ap/app.dart';
import 'package:nkust_ap/config/constants.dart';
import 'package:nkust_ap/res/app_icon.dart';
import 'package:nkust_ap/res/app_theme.dart';
import 'package:nkust_ap/utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isInDebugMode = Constants.isInDebugMode;
  await Preferences.init();
  AppIcon.code =
      Preferences.getString(Constants.PREF_ICON_STYLE_CODE, AppIcon.OUTLINED);
  AppTheme.code =
      Preferences.getString(Constants.PREF_THEME_CODE, AppTheme.LIGHT);
  _setTargetPlatformForDesktop();
  if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    Crashlytics.instance.enableInDevMode = isInDebugMode;
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
    runZoned<Future<void>>(() async {
      runApp(
        MyApp(
          themeData: AppTheme.data,
        ),
      );
    }, onError: Crashlytics.instance.recordError);
  } else {
    runApp(
      MyApp(
        themeData: AppTheme.data,
      ),
    );
  }
}

void _setTargetPlatformForDesktop() {
  if (!kIsWeb && (Platform.isLinux || Platform.isWindows)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}
