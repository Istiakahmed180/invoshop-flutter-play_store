import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/refund_policy/controller/refund_policy_controller.dart';

class RefundScreen extends StatelessWidget {
  const RefundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RefundPolicyController refundPolicyController =
        Get.put(RefundPolicyController());

    return Scaffold(
      appBar: const CustomAppBar(appBarName: 'Refund Policy'),
      body: Obx(
        () {
          final refundPolicyData =
              refundPolicyController.refundPolicyModel.value.data;
          if (refundPolicyController.isLoading.value) {
            return CustomLoading(withOpacity: 0.0);
          } else if (refundPolicyData == null ||
              refundPolicyData.pageContents == null ||
              refundPolicyData.pageContents!.layoutSections == null ||
              refundPolicyData.pageContents!.layoutSections!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final layoutSections = refundPolicyData.pageContents!.layoutSections!;
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
      ),
    );
  }
}
