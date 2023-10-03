import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/scaffoldLayout.widget.dart';
import 'package:fly_ui/views/layouts/scaffoldPadding.widget.dart';
import 'package:fly_ui/views/widgets/appBar.widget.dart';
import 'package:get/get.dart';
import 'package:scale_module/views/widgets/InformationScreen.widget.dart';
import 'package:scale_module/views/widgets/numbersPad.widget.dart';
import 'package:scale_module/views/widgets/toolsButtons.widget.dart';

class PortraitLayout extends StatelessWidget {
  const PortraitLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlyScaffold(
      appBar: FlyAppBar(
        title: 'Food Scale'.tr,
      ),
      child: const FlyScaffoldPadding(
        child: Column(
          children: [
            CalculatorInformationScreen(),
            CalculatorToolsButtons(),
            Expanded(
              child: CalculatorNumbersPad(),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
