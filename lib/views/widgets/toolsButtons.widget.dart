import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fly_ui/views/widgets/inkWell.widget.dart';
import 'package:get/get.dart';
import 'package:scale_module/views/foodScale.controller.dart';
import 'package:unicons/unicons.dart';

class CalculatorToolsButtons extends GetView<FoodScaleController> {
  const CalculatorToolsButtons({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
