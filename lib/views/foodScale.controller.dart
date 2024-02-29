import 'package:bottom_sheet_helper/models/actionSheetOption.model.dart';
import 'package:bottom_sheet_helper/services/actionSheet.helper.dart';
import 'package:bottom_sheet_helper/services/customBottomSheet.helper.dart';
import 'package:bottom_sheet_helper/services/messageBottomSheet.helper.dart';
import 'package:calculator_module/widgets/calculatorManualValueField.widget.dart';
import 'package:diabetes_enums/weightUnit.enum.dart';
import 'package:diabetes_models/food.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:ruler_picker/rulerPicker.dart';
import 'package:scale_module/helpers/foodFacts.helper.dart';

class FoodScaleController extends GetxController {
  // define
  static FoodScaleController get to => Get.find();

  // Services
  final FoodsFactsHelper _foodsFactsService = FoodsFactsHelper();

  // static properties
  final Food initFood = Get.arguments;

  // // the food that will apply changes on it
  final Rx<Food?> food = Rx<Food?>(null);

  // Units
  final List<ScaleUnit> units = ScaleUnit.values;

  // Unit for Scale , Gram,...
  final Rx<ScaleUnit> selectedUnit = Rx<ScaleUnit>(ScaleUnit.Gram);

  // full Weight number , 1.3,1.4,1.5 ....
  final RxNum weightNumber = RxNum(0);

  // manual field controller
  final TextEditingController valueManualController = TextEditingController();

  @override
  void onInit() {
    // assignment food into new object of food
    food.value = Food.fromData(initFood.toData());
    selectedUnit.value = initFood.scale.unit;
    weightNumber.value = initFood.scale.weight.toInt();

    super.onInit();

    weightNumber.listen((_) {
      // re-calculating
      changeFoodFactsPerUserChanges();
    });
  }

  @override
  void onClose() {
    valueManualController.dispose();
    super.onClose();
  }

  // When user change ruler
  void onValueChange(num? newValue) {
    weightNumber.value = newValue as double;
  }

  void onCalculatorChange(num value) {
    weightNumber.value = value;
  }

  // Change changedFood Object
  // applied changes on food object every time user change values
  void changeFoodFactsPerUserChanges() {
    food.value = _foodsFactsService.changeFactsPerWeight(
      unit: selectedUnit.value,
      weight: weightNumber.value.toDouble(),
      food: initFood,
    );
  }

  // reset Only Weight value
  void resetWeightValues() {
    weightNumber.value = 0;
  }

  // when user change Unit
  onChangeUnit() async {
    // show bottom sheet to make user choose one
    final ScaleUnit? payload = await ActionSheetHelper.show(
      title: 'Scale units'.tr,
      options: ScaleUnit.values
          .map((e) => ActionSheetOption(title: e.name.tr, value: e))
          .toList(),
      height: Get.height * 0.6,
    ) as ScaleUnit?;

    if (payload == null) return;

    // assign new unit
    selectedUnit.value = payload;

    // reset
    resetWeightValues();
  }

  // when user tap on confirm
  void save() {
    // alert user to skip this
    if (weightNumber.value <= 0) {
      // close scale
      Get.back();
      // show message
      MessageBottomSheetHelper.show(
          title: "Empty Scale",
          body:
              'has canceled due to scale is empty, you have to scale 1 gram at least.');
      return;
    }

    // else return with food object to save
    Get.back(result: food.value);
  }

  // Change Scale by Soft Keyboard
  Future<void> onOpenSoftKeyboard() async {
    //  set current value
    valueManualController.text = weightNumber.value.toString();

    // Show bottom
    await CustomBottomSheetHelper.show(
      title: 'Keyboard'.tr,
      subTitle: 'Change value by keyboard.'.tr,
      child: CalculatorManualValueFieldWidget(
        controller: valueManualController,
        label: selectedUnit.value.name.tr,
        onConfirm: () => changeValueManual(),
        onReset: () => resetValueManual(),
      ),
    );
  }

  void changeValueManual() {
    // value of text
    final String value = valueManualController.text;

    // Skip
    if (value.isEmpty) return Get.back();

    // convert to num
    weightNumber.value = double.parse(valueManualController.text);

    // close sheet
    Get.back();
  }

  void resetValueManual() => valueManualController.clear();
}
