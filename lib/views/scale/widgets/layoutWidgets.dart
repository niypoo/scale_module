// import 'package:app_configuration_service/appInfo.config.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:fly_ui/views/widgets/buttons/circalButton.widget.dart';
// import 'package:fly_ui/views/widgets/buttons/elevatedButton.widget.dart';
// import 'package:fly_ui/views/widgets/buttons/iconButton.widget.dart';
// import 'package:fly_ui/views/widgets/buttons/textButton.widget.dart';
// import 'package:fly_ui/views/widgets/inkWell.widget.dart';
// import 'package:get/get.dart';
// import 'package:ruler_picker/rulerPicker.dart';
// import 'package:scale_module/views/scale/foodScale.controller.dart';
// import 'package:unicons/unicons.dart';

// class PagesButtons extends GetView<FoodScaleController> {
//   const PagesButtons({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: AppConfigService.to.space!.m,
//         left: AppConfigService.to.space!.xl,
//         right: AppConfigService.to.space!.xl,
//       ),
//       child: Column(
//         children: [
//           // Confirm
//           FlyElevatedButton(
//             color: Get.theme.scaffoldBackgroundColor,
//             title: 'Confirm'.tr,
//             onPressed: controller.confirm,
//           ),

//           // NO Thanks  => Back
//           FlyTextButton(
//             title: 'Cancel'.tr,
//             onTap: controller.cancel,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EditValueManual extends GetView<FoodScaleController> {
//   const EditValueManual({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FlyIconButton(
//       icon: UniconsLine.edit_alt,
//       onPressed: controller.showValueManuelSheet,
//     );
//   }
// }

// class PageRule extends GetView<FoodScaleController> {
//   const PageRule({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.symmetric(vertical: AppConfigService.to.space!.xl),
//         child: 

//         Directionality(
//           textDirection: TextDirection.ltr,
//           child: RulerPicker(
//             backgroundColor: Colors.transparent,
//             controller: controller.rulerController,
//             onValueChange: controller.onValueChange,
//             width: context.isLandscape ? context.height : context.width,
//             height: (context.isLandscape ? context.height : context.width) * 0.4,
//             initValue: controller.weightNumber.toDouble(),
//             fractionDigits: 1,
//             color: Get.theme.cardColor,
//             lineColor: Get.iconColor!,
//             marker: SizedBox(
//               height: (Get.width * 0.3) * 0.8,
//               child: VerticalDivider(
//                 color: Get.theme.primaryColor,
//                 thickness: 2,
//               ),
//             ),
//           ),
//         ),
//         );
//   }
// }

// class WeightCarbsContainsWidget extends GetView<FoodScaleController> {
//   const WeightCarbsContainsWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: AppConfigService.to.space!.s),
//       child: Obx(
//         () => Text.rich(
//           TextSpan(
//             text: 'Contains on'.tr,
//             children: [
//               const TextSpan(text: ' '),
//               TextSpan(
//                 text:
//                     '${controller.changedFood.value!.carbs.toStringAsFixed(1)} ${'Carbs'.tr}',
//                 style: Get.theme.textTheme.bodyLarge,
//               ),
//               // TextSpan(text: ' | '),
//               // TextSpan(
//               //   text: '${food.gl.toStringAsFixed(1)} ${'GL'.tr}',
//               //   style: Get.theme.textTheme.subtitle2
//               //       .copyWith(fontWeight: FontWeight.w900),
//               // ),
//             ],
//           ),
//           style: Get.theme.textTheme.bodySmall,
//         ),
//       ),
//     );
//   }
// }

// class WeightNumberWidget extends GetView<FoodScaleController> {
//   const WeightNumberWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: AppConfigService.to.space!.m),
//       child: Directionality(
//         textDirection: TextDirection.ltr,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Decrement
//             Obx(
//               () => FlyCircleButton(
//                 color: Get.theme.scaffoldBackgroundColor,
//                 icon: UniconsLine.minus,
//                 onPressed: controller.weightNumber.value <= 0
//                     ? null
//                     : controller.decrementTap,
//               ),
//             ),

//             Expanded(
//               child: Container(
//                 height: 60,
//                 padding: EdgeInsets.symmetric(
//                     horizontal: AppConfigService.to.space!.m),
//                 child: Obx(
//                   () => Text(
//                     controller.weightNumber.value.toString(),
//                     style: Get.theme.textTheme.titleMedium,
//                     maxLines: 1,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),

//             // increment
//             FlyCircleButton(
//               color: Get.theme.scaffoldBackgroundColor,
//               icon: UniconsLine.plus,
//               onPressed: controller.incrementTap,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WeightUnitWidget extends GetView<FoodScaleController> {
//   const WeightUnitWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(AppConfigService.to.space!.m),
//       child: FlyInkWell(
//         onTap: controller.onChangeWeightUnit,
//         child: Padding(
//           padding: EdgeInsets.all(AppConfigService.to.space!.s),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Obx(
//                 () => Text(
//                   describeEnum(controller.weightUnit.value).tr,
//                   style: Get.theme.textTheme.titleSmall,
//                   maxLines: 2,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Icon(Icons.arrow_drop_down, color: Get.theme.iconTheme.color),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
