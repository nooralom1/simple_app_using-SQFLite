// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:simple_app/common_widgets/custom_button.dart';
import 'package:simple_app/constants/app_constants.dart';
import 'package:simple_app/gen/colors.gen.dart';
import 'package:simple_app/helpers/di.dart';
import 'package:simple_app/helpers/ui_helpers.dart';

Future<void> setInitValue() async {
  await appData.writeIfNull(kKeyIsLoggedIn, false);
  await appData.writeIfNull(kKeyIsFirstTime, true);

  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
  }
  await Future.delayed(const Duration(seconds: 2));
}

Future<void> initiInternetChecker() async {
  InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 1),
    checkInterval: const Duration(seconds: 2),
  ).onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        // ToastUtil.showShortToast('Data connection is available.');
        break;
      case InternetConnectionStatus.disconnected:
        // ToastUtil.showNoInternetToast();
        break;
      case InternetConnectionStatus.slow:
    }
  });
}

void showMaterialDialog(BuildContext context) {
  showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        "Do you want to exit the app?",
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        CustomButton(
          text: "No",
          onTap: () {
            Navigator.of(context).pop(false);
          },
          borderRadius: 30.r,
        ),
        UIHelper.verticalSpace(16.h),
        CustomButton(
          text: "Yes",
          onTap: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
          borderRadius: 30.r,
          borderColor: AppColors.primaryColor,
        ),
      ],
    ),
  );
}

void rotation() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
