import 'package:get/get.dart';
import 'foodScale.controller.dart';

class FoodScaleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodScaleController>(() => FoodScaleController());
  }
}
