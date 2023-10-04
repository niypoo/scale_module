import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fly_ui/views/widgets/containers/container.widget.dart';
import 'package:get/get.dart';
import 'package:scale_module/views/foodScale.controller.dart';
import 'package:auto_size_text/auto_size_text.dart';


class CalculatorInformationScreen extends GetView<FoodScaleController> {
  const CalculatorInformationScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return FlyContainer(
      child: SizedBox(
        height: Get.height * 0.25,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Number
            Flexible(
              child: Obx(
                () => AutoSizeText.rich(
                  TextSpan(
                    text: controller.weightNumber.value.toString(),
                    children: [
                      const TextSpan(text: ' '),
                      TextSpan(
                        text:
                            describeEnum(controller.selectedUnit.value)
                                .tr,
                        style: Get.theme.textTheme.labelLarge
                            ?.copyWith(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  style: Get.theme.textTheme.headlineLarge!
                      .copyWith(fontSize: 60),
                  maxLines: 1,
                ),
              ),
            ),

            // Carbs
            Obx(
              () => AutoSizeText.rich(
                TextSpan(
                  text: controller.food.value!.name,
                  children: [
                    const TextSpan(
                      text: ' ',
                    ),
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
                      style: Get.theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                style: Get.theme.textTheme.bodyLarge,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
