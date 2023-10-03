import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/responsiveView.widget.dart';
import 'package:scale_module/views/layouts/landscape.layout.dart';
import 'package:scale_module/views/layouts/portrait.layout.dart';
class FoodScaleView extends StatelessWidget {
  const FoodScaleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FlyLayoutResponsiveView(
      landscape: LandscapeLayout(),
      portrait: PortraitLayout(),
    );
  }
}
