import 'package:get/get.dart';
import 'package:spacex/ui/homepage.dart';

class SplashScreenController extends GetxController {
  nextScreen() {
    Future.delayed(const Duration(seconds: 7), () {
      Get.offAll(() => const Homepage());
    });
  }
}
