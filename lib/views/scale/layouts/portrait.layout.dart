import 'package:app_configuration_service/appInfo.config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/scaffoldPadding.widget.dart';
import 'package:get/get.dart';
import 'package:scale_module/views/scale/foodScale.controller.dart';
import 'package:scale_module/views/scale/widgets/layoutWidgets.dart';

class PortraitLayout extends GetView<FoodScaleController> {
  const PortraitLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top margin
                SizedBox(height: AppConfigService.to.space!.xl),

                // Info
                const FlyScaffoldPadding(
                  child: Column(
                    children: [
                      // Units
                      WeightUnitWidget(),
                      // Number
                      WeightNumberWidget(),
                      // Carbs
                      WeightCarbsContainsWidget(),

                      // Edit Manual
                      EditValueManual(),
                    ],
                  ),
                ),

                // Top margin
                SizedBox(height: AppConfigService.to.space!.xl),

                // Rule
                const PageRule(),
              ],
            ),
          ),
        ),
        // Buttons
        const PagesButtons(),
      ],
    );
  }
}
