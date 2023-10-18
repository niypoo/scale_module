import 'package:calculator_module/widgets/calculatorInformationScreen.widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scale_module/views/foodScale.controller.dart';
import 'package:auto_size_text/auto_size_text.dart';

class InformationScreen extends GetView<FoodScaleController> {
  const InformationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CalculatorInformationScreenWidget(
        // NUMBERS
        number: controller.weightNumber.value.toString(),

        // LABELs
        label: describeEnum(controller.selectedUnit.value).tr,

        // TITLE
        title: Column(
          children: [
            AutoSizeText(
              controller.food.value!.name,
              style: Get.theme.textTheme.titleLarge,
            ),
            AutoSizeText.rich(
              TextSpan(
                text: 'Contains on'.tr,
                children: [
                  const TextSpan(text: ' '),
                  TextSpan(
                    text:
                        '${controller.food.value!.carbs.toStringAsFixed(1)} ${'Carbs'.tr}',
                    style: Get.theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              style: Get.theme.textTheme.bodySmall,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
