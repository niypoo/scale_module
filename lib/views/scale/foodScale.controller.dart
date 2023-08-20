import 'package:bottom_sheet_helper/models/actionSheetOption.model.dart';
import 'package:bottom_sheet_helper/services/actionSheet.helper.dart';
import 'package:bottom_sheet_helper/services/customBottomSheet.helper.dart';
import 'package:bottom_sheet_helper/services/messageBottomSheet.helper.dart';
import 'package:diabetes_enums/weightUnit.enum.dart';
import 'package:diabetes_models/food.model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:ruler_picker/rulerPicker.dart';
import 'package:scale_module/helpers/foodFacts.helper.dart';
import 'package:scale_module/views/scale/widgets/valueManul.widget.dart';

class FoodScaleController extends GetxController {
  // define
  static FoodScaleController get to => Get.find();

  // properties
  // final RulerPickerController rulerController = RulerPickerController();

  // Services
  final FoodsFactsHelper _foodsFactsService = FoodsFactsHelper();

  // static properties
  final Food? food = Get.arguments;

  final List<ScaleUnit> weightUnits = ScaleUnit.values;
  final double itemExtent = 35.5;

  // Unit for Scale , Gram,...
  final Rx<ScaleUnit> weightUnit = Rx<ScaleUnit>(ScaleUnit.Gram);

  // full Weight number , 1.3,1.4,1.5 ....
  final RxDouble weightNumber = RxDouble(0.0);

  // the food that will apply changes on it
  final Rx<Food?> changedFood = Rx<Food?>(null);

  final TextEditingController valueManualController = TextEditingController();

  @override
  void onInit() {
    if (food == null) {
      return Get.back();
    } else {
      // assignment food into new object of food
      // to handle scale on it
      changedFood.value = food;

      weightUnit.value = food!.scale.unit;

      // assign full weight
      changeRuleNumber(food!.scale.weight.toDouble());

      // ThemeController.to.setSystemUI(
      //   systemNavigationBarColor: Get.theme.cardColor,
      //   statusBarColor: Get.theme.cardColor,
      // );
    }
    super.onInit();
  }

  @override
  void onClose() {
    // reset system Ui
    // ThemeController.to.setSystemUI();
    // rulerController.dispose();
    valueManualController.dispose();
    super.onClose();
  }

  // When user change ruler
  void onValueChange(num? newValue) {
    weightNumber.value = newValue as double;
    // applied values on changedFood
    changeFoodFactsPerUserChanges();
  }

  // Change changedFood Object
  // applied changes on food object every time user change values
  void changeFoodFactsPerUserChanges() {
    changedFood.value = _foodsFactsService.changeFactsPerWeight(
      unit: weightUnit.value,
      weight: weightNumber.value,
      food: food!,
    );
  }

  // reset Only Weight value
  void resetWeightValues() {
    weightNumber.value = 0.0;
    // rulerController.value = 0.0;
  }

  void incrementTap() {
    changeRuleNumber(weightNumber.value + 0.1);
    // applied values on changedFood
    changeFoodFactsPerUserChanges();
  }

  void decrementTap() {
    changeRuleNumber(weightNumber.value - 0.1);
    // applied values on changedFood
    changeFoodFactsPerUserChanges();
  }

  changeRuleNumber(double number) {
    double floatNumber = double.parse(number.toStringAsFixed(1));
    // assign new unit
    // rulerController.value = floatNumber;
    weightNumber.value = floatNumber;
  }

  // when user change Unit
  onChangeWeightUnit() async {
    // show bottom sheet to make user choose one
    final ScaleUnit? unit = await ActionSheetHelper.show(
      title: 'Scale units'.tr,
      options: ScaleUnit.values
          .map((e) => ActionSheetOption(title: describeEnum(e).tr, value: e))
          .toList(),
      height: 0.6,
    ) as ScaleUnit?;

    if (unit == null) return;

    // assign new unit
    weightUnit.value = unit;

    // reset
    resetWeightValues();

    // applied values on changedFood
    changeFoodFactsPerUserChanges();
  }

  // when user tap on confirm
  void confirm() {
    // alert user to skip this
    if (weightNumber.value <= 0) {
      // close scale
      Get.back();
      // show message
      MessageBottomSheetHelper.show(
          title: "Empty Scale",
          subTitle:
              'has canceled due to scale is empty, you have to scale 1 gram at least.');
      return;
    }

    // else return with food object to save
    Get.back(result: changedFood.value);
  }

  void cancel() => Get.back();

  // CHange Value By Soft Keyboard
  // Chang value by manul

  // change valueby manul by softkeypoard
  Future<void> showValueManuelSheet() async {
    //  set current value
    valueManualController.text = weightNumber.value.toString();

    // Show bottom
    await CustomBottomSheetHelper.show(
      title: food!.name,
      child: ChangeValueManual(
        controller: valueManualController,
        label: describeEnum(weightUnit).tr,
        onConfirm: () => changeValueManual(),
        onReset: () => resetValueManual(),
      ),
    );
  }

  void changeValueManual() {
    // value of text
    final String value = valueManualController.text;

    // Skip
    if (value.isEmpty) return cancel();

    // convert to num
    final num valueAsNum = num.parse(valueManualController.text);

    // rulerController.value = valueAsNum;

    cancel();
  }

  void resetValueManual() => valueManualController.clear();
}
