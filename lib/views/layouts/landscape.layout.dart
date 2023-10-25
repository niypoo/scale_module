import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/landscapeView.widget.dart';
import 'package:fly_ui/views/layouts/scaffoldLayout.widget.dart';
import 'package:fly_ui/views/layouts/scaffoldPadding.widget.dart';
import 'package:fly_ui/views/widgets/appBar.widget.dart';
import 'package:get/get.dart';
import 'package:scale_module/views/widgets/InformationScreen.widget.dart';
import 'package:scale_module/views/widgets/numbersPad.widget.dart';
import 'package:scale_module/views/widgets/toolsButtons.widget.dart';

class LandscapeLayout extends StatelessWidget {
  const LandscapeLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlyScaffold(
      appBar: FlyAppBar(
        title: 'Food Scale'.tr,
      ),
      child: const FlyScaffoldPadding(
        child: FlyLandscapeView(
          childB: Column(
            children: [
              Expanded(child: InformationScreen()),
              CalculatorToolsButtons(),
            ],
          ),
          childA: Column(
            children: [
              Expanded(child: NumbersPad()),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
