import 'package:get/get.dart';
import 'package:password_manager/screens/home_screen.dart';
import 'package:password_manager/utils/preference_utils.dart';

class SplashController extends GetxController {
  void initAdministration() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isFirstTime = PreferenceUtils.getBool("isFirstTime", true);
    Get.off(() => const HomeScreen(), arguments: isFirstTime);
  }

  @override
  void onInit() {
    super.onInit();
    initAdministration();
  }
}
