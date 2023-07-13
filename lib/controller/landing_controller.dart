import 'package:get/get.dart';

class LandingController extends GetxController {
  bool rightButton = false;
  bool leftButton = false;

  changeRightButton(bool value) {
    rightButton = value;
    update();
  }

  changeLeftButton(bool value) {
    leftButton = value;
    update();
  }
}
