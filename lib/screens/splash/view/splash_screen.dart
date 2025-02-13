import 'dart:async';

import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _logoAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
      ),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _moveToNextPage();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  Future<void> _moveToNextPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    final String? supplierKey = prefs.getString("supplier_key");
    if (token != null && token.isNotEmpty) {
      Timer(const Duration(seconds: 5), () {
        Get.toNamed(BaseRoute.home);
      });
    } else if (supplierKey != null && supplierKey.isNotEmpty) {
      Timer(const Duration(seconds: 5), () {
        Get.toNamed(BaseRoute.signIn);
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        Get.toNamed(BaseRoute.onBoarding);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      AppColors.grocerySecondary,
      AppColors.groceryPrimary,
      AppColors.grocerySecondary
    ];

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _logoAnimation,
                    child: Hero(
                      tag: 'logoHero',
                      child: Image.asset(
                        "assets/logos/Inventual_logo.png",
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _textAnimation,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedTextKit(animatedTexts: [
                              ColorizeAnimatedText(
                                "E-commerce Solutions",
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    letterSpacing: 4.w,
                                    fontWeight: FontWeight.w600,
                                    shadows: const [
                                      Shadow(
                                        color: AppColors.groceryBody,
                                        blurRadius: 2,
                                        offset: Offset(1, 1),
                                      ),
                                    ]),
                                colors: colorizeColors,
                                speed: const Duration(milliseconds: 500),
                              )
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: FadeTransition(
                opacity: _animation,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Powered By BDevs",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    Text(
                      "V 1.0.1",
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
