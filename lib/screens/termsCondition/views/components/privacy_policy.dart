import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/termsCondition/controller/terms_condition_controller.dart';

class PrivacyPolicy extends StatelessWidget {
  final String type;
  final TermsConditionController termsConditionController;

  const PrivacyPolicy(
      {super.key, required this.type, required this.termsConditionController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final privacyPolicyData =
            termsConditionController.privacyPolicyModel.value.data;
        if (termsConditionController.isLoading.value) {
          return CustomLoading(withOpacity: 0.0);
        } else if (privacyPolicyData == null ||
            privacyPolicyData.pageContents == null ||
            privacyPolicyData.pageContents!.layoutSections == null ||
            privacyPolicyData.pageContents!.layoutSections!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        final layoutSections = privacyPolicyData.pageContents!.layoutSections!;
        final firstContainer = layoutSections[0].containers;
        if (firstContainer == null || firstContainer.isEmpty) {
          return Center(child: Text('No content available'));
        }

        final widgets = firstContainer[0].widgets;
        if (widgets == null || widgets.isEmpty) {
          return Center(child: Text('No widgets available'));
        }
        final aboutContent = widgets[0].contentData?.content ?? '';

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
                child: HtmlWidget(aboutContent),
              )),
        );
      },
    );
  }
}
