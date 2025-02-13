import 'package:ai_store/constants/app_colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results.first);
    });
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          messageText: const Text(
            'PLEASE CONNECT TO THE INTERNET',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 20,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          mainButton: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                Get.closeCurrentSnackbar();
              },
              child: const Text(
                'CLOSE',
                style: TextStyle(
                  color: AppColors.groceryBody,
                ),
              ),
            ),
          ));
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
