import 'package:food_mobile_app_ui/navigator.dart';
import 'package:get/get.dart';

//
import 'package:food_mobile_app_ui/pages/introduction.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  /// For showing introduction screen just once
  final box = GetStorage();

  bool get hasUser => box.read('user') != null;



  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 10),
      () {
        Get.offAll(
            () => hasUser == true
                ? const MainNavigator()
                : const IntroductionPage(),
            transition: Transition.cupertino);
      },
    );
    super.onInit();
  }
}
