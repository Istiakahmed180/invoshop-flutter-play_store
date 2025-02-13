import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/config/routes/routes_handler.dart';
import 'package:ai_store/config/theme/dark_theme.dart';
import 'package:ai_store/config/theme/light_theme.dart';
import 'package:ai_store/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 300),
          themeMode: ThemeMode.light,
          theme: LightTheme().lightTheme(context),
          darkTheme: DarkTheme().darkTheme(context),
          getPages: routesHandler,
          initialRoute: BaseRoute.splash,
          unknownRoute: routesHandler.first,
        );
      },
    );
  }
}
