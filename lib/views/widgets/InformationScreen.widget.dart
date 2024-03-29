import 'package:calculator_module/widgets/calculatorInformationScreen.widget.dart';
import 'package:flutter/material.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
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
        label: controller.selectedUnit.value.name.tr,

        // TITLE
        title: controller.food.value == null
            ? const SizedBox.shrink()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text('From'.tr),
                  AutoSizeText(
                    controller.food.value!.name,
                    style: Get.theme.textTheme.titleLarge!.copyWith(
                      height: 1.5,
                      fontSize: 20.sp,
                    ),
                    maxLines: 1,
                  ),
                  AutoSizeText.rich(
                    TextSpan(
                      text: 'Contains on'.tr,
                      children: [
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: controller.food.value!.carbs.toStringAsFixed(1),
                          style: Get.theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: 'Carbs'.tr,
                          style: Get.theme.textTheme.bodySmall!.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                      style: Get.theme.textTheme.bodySmall!.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
