import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxString categoryValue = ''.obs;

  void onItemTapped(int index, {String category = ''}) {
    selectedIndex.value = index;
    categoryValue.value = category;
  }
}
