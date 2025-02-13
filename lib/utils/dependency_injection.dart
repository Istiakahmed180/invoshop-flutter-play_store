import 'package:ai_store/network/internet_connectivity_controller.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    Get.put<InternetConnectivityController>(InternetConnectivityController(),
        permanent: true);
  }
}
