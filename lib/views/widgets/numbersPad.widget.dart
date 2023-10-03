import 'package:calculator_module/board/calculatorNumberBoard.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scale_module/views/foodScale.controller.dart';

class CalculatorNumbersPad extends GetView<FoodScaleController> {
  const CalculatorNumbersPad({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CalculatorNumberBoardWidget(
        initValue: controller.weightNumber.value,
        onChange: controller.onCalculatorChange,
        onSave: controller.save,
      ),
    );
  }
}