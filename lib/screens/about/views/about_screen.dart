import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/about/controller/about_us_controller.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AboutUsController aboutUsController = Get.put(AboutUsController());

    return Scaffold(
      appBar: const CustomAppBar(appBarName: 'About Us'),
      body: Obx(
        () {
          final aboutUsData = aboutUsController.aboutUsModel.value.data;
          if (aboutUsController.isLoading.value) {
            return CustomLoading(withOpacity: 0.0);
          } else if (aboutUsData == null ||
              aboutUsData.pageContents == null ||
              aboutUsData.pageContents!.layoutSections == null ||
              aboutUsData.pageContents!.layoutSections!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final layoutSections = aboutUsData.pageContents!.layoutSections!;
          final firstContainer = layoutSections[0].containers;
          if (firstContainer == null || firstContainer.isEmpty) {
            return Center(child: Text('No content available'));
          }

          final widgets = firstContainer[0].widgets;
          if (widgets == null || widgets.isEmpty) {
            return Center(child: Text('No widgets available'));
          }

          final aboutHeading = widgets[0].contentData?.aboutHeading ?? '';
          final aboutContent = widgets[0].contentData?.aboutContent ?? '';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: AppColors.groceryBorder)),
              color: Colors.white.withValues(alpha: 0.8),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aboutHeading,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 10.h),
                    HtmlWidget(aboutContent),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
