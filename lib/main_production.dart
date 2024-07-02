import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'core/di/dependency_injection.dart';
import 'core/helpers/constants.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'core/routing/app_router.dart';
import 'doc_app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Future.wait([
    setupGetIt(),
    ScreenUtil.ensureScreenSize(),
    preloadSVGs([
      'assets/svgs/docdoc_logo_low_opacity.svg',
      'assets/svgs/docdoc_logo.svg',
      'assets/svgs/general_speciality.svg',
      'assets/svgs/notifications.svg',
    ]),
  ]);
  await checkIfUserIsLoggedIn();
  runApp(
    DocApp(
      appRouter: AppRouter(),
    ),
  );
  FlutterNativeSplash.remove();
}


Future<void> checkIfUserIsLoggedIn() async {
  String? userToken =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  if (userToken!.startsWith('e')) {
    isLoggedInUser = true;
  }
}

Future<void> preloadSVGs(List<String> paths) async {
  for (final path in paths) {
    final loader = SvgAssetLoader(path);
    await svg.cache.putIfAbsent(
      loader.cacheKey(null),
      () => loader.loadBytes(null),
    );
  }
}
