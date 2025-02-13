import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: OnBoardingSlider(
          pageBackgroundColor: Colors.white,
          finishButtonText: "Find Supplier",
          onFinish: () {
            Get.offNamed(BaseRoute.findSupplier);
          },
          finishButtonStyle: const FinishButtonStyle(
            backgroundColor: AppColors.groceryPrimary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
          ),
          trailing: Container(
            color: Colors.white,
          ),
          skipTextButton: Text(
            "Skip",
            style: GoogleFonts.raleway(
                textStyle: const TextStyle(
                    fontSize: 16,
                    color: AppColors.groceryPrimary,
                    fontWeight: FontWeight.w700)),
          ),
          controllerColor: AppColors.groceryPrimary,
          totalPage: 3,
          headerBackgroundColor: Colors.white,
          background: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/onboarding/slide-1.png',
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/onboarding/slide-2.png',
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/onboarding/slide-3.png',
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
              ),
            ),
          ],
          speed: 2,
          pageBodies: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.5,
                  ),
                  Text(
                    'Perfect Products for You',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                      color: AppColors.groceryTitle,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Explore a wide range of high-quality grocery products tailored to meet your every need. Whether you're shopping for fresh produce, pantry staples, or specialty items, we've got you covered",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: AppColors.groceryText,
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.5,
                  ),
                  Text(
                    'Shopping Experience',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                      color: AppColors.groceryTitle,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Our user-friendly platform ensures that your shopping experience is smooth and enjoyable. With easy navigation and quick checkouts, shopping has never been this effortless.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: AppColors.groceryText,
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.5,
                  ),
                  Text(
                    'Fast and Reliable Delivery',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: AppColors.groceryTitle,
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Get your orders delivered swiftly and safely to your doorstep. Our trusted delivery partners ensure that your purchases arrive on time, every time.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: AppColors.groceryText,
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
