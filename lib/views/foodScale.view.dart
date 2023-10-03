import 'package:calculator_module/board/calculatorNumberBoard.widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/responsiveView.widget.dart';
import 'package:fly_ui/views/layouts/scaffoldLayout.widget.dart';
import 'package:fly_ui/views/layouts/scaffoldPadding.widget.dart';
import 'package:fly_ui/views/widgets/appBar.widget.dart';
import 'package:fly_ui/views/widgets/containers/container.widget.dart';
import 'package:fly_ui/views/widgets/inkWell.widget.dart';
import 'package:get/get.dart';
import 'package:scale_module/views/foodScale.controller.dart';
import 'package:unicons/unicons.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FoodScaleView extends GetView<FoodScaleController> {
  const FoodScaleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlyScaffold(
      appBar: FlyAppBar(
        title: 'Food Scale'.tr,
      ),
      child: FlyScaffoldPadding(
        child: FlyResponsiveView(
          child: Column(
            children: [
              FlyContainer(
                child: SizedBox(
                  height: Get.height * 0.15,
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
              ),
              Container(
                height: 48.0,
                width: double.maxFinite,
                color: Get.theme.scaffoldBackgroundColor,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 8,
                    children: [
                    
                      FlyInkWell(
                        onTap: controller.onChangeUnit,
                        child: Chip(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          backgroundColor: Get.theme.cardColor,
                          avatar: Icon(UniconsLine.angle_down,
                              color: Get.theme.iconTheme.color),
                          label: Obx(
                            () => Text(
                              describeEnum(controller.selectedUnit.value).tr,
                              style: Get.theme.textTheme.titleSmall,
                            ),
                          ),
                        ),
                      ),
                      FlyInkWell(
                        onTap: controller.onOpenSoftKeyboard,
                        child: Chip(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          backgroundColor: Get.theme.cardColor,
                          label: Text('Keyboard'.tr,      style: Get.theme.textTheme.titleSmall,),
                          avatar: const Icon(UniconsLine.keyboard),
                        ),
                      ),
                
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Obx(
                  () => CalculatorNumberBoardWidget(
                    initValue: controller.weightNumber.value,
                    onChange: controller.onCalculatorChange,
                    onSave: controller.save,
                  ),
                ),
              ),
                   const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
