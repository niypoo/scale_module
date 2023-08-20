import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/scaffoldLayout.widget.dart';
import 'package:fly_ui/views/widgets/appBar.widget.dart';
import 'package:get/get.dart';
import 'layouts/landscape.layout.dart';
import 'layouts/portrait.layout.dart';

class FoodScaleView extends StatelessWidget {
  const FoodScaleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlyScaffold(
      backgroundColor: Get.theme.cardColor,
      appBar: context.isLandscape
          ? null
          : FlyAppBar(
              backgroundColor: Get.theme.cardColor,
              // title: controller.food?.name ?? ' ',
            ),
      // body
      child: context.isLandscape ? LandscapeLayout() : PortraitLayout(),
    );
  }
}
