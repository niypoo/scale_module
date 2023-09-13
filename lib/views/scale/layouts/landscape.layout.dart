import 'package:app_configuration_service/appInfo.config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/landscapeView.widget.dart';
import 'package:fly_ui/views/layouts/scaffoldPadding.widget.dart';
import 'package:fly_ui/views/widgets/appBar.widget.dart';
import 'package:get/get.dart';
import 'package:scale_module/views/scale/foodScale.controller.dart';
import 'package:scale_module/views/scale/widgets/layoutWidgets.dart';

class LandscapeLayout extends GetView<FoodScaleController> {
  const LandscapeLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlyLandscapeView(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      childA: Column(
        children: [
          FlyScaffoldPadding(
            child: FlyAppBar(
              backgroundColor: Get.theme.cardColor,
              title: controller.food?.name ?? ' ',
              padding: 0.0,
            ),
          ),
          // padding
          SizedBox(height: AppConfigService.to.space!.xl),
          // Units
          const WeightUnitWidget(),
          // Number
          const WeightNumberWidget(),
          // Carbs
          const WeightCarbsContainsWidget(),
          // Edit Manual
          const EditValueManual(),
        ],
      ),
      childB: Column(
        children: const [
          // Rule
          PageRule(),

          // Buttons
          PagesButtons(),
        ],
      ),
    );
  }
}
