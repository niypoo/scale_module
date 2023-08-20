import 'package:diabetes_enums/weightUnit.enum.dart';
import 'package:diabetes_models/food.model.dart';
import 'package:get/get.dart';
import 'package:scale_module/views/scale/foodScale.binding.dart';
import 'package:scale_module/views/scale/foodScale.view.dart';

class FoodScaleHelper {
  // open Weight Piker to ask user about weight and
  // handle carbs and other
  static Future<Food?> scale(Food food) async => await Get.to(
        const FoodScaleView(),
        binding: FoodScaleBinding(),
        arguments: food,
      ) as Food?;

  // get how much weight user will eat
  // per grams
  // like 3.5 tablespoon = 49 gram
  static double weightToGrams({
    required ScaleUnit unit,
    required double weight,
  }) {
    // how many unit equaled in grams
    // like Tablespoon = 15 grams
    final double unitPreGrams = oneUnitPreGrams(unit);

    // get total grams for weight
    // like 3.5 tablespoon = 49 grams
    final double totalGrams = unitPreGrams * weight;

    // avoid NaN
    return totalGrams;
  }

  // how many unit equaled in grams
  // like Tablespoon = 15 grams
  static double oneUnitPreGrams(ScaleUnit unit) {
    double unitPreGrams = 0;

    // define unit
    switch (unit) {
      case ScaleUnit.Tablespoon:
        unitPreGrams = 14.3;

      case ScaleUnit.Teaspoon:
        unitPreGrams = 5.69;

      case ScaleUnit.Cup:
        unitPreGrams = 128;

      case ScaleUnit.Kilo:
        unitPreGrams = 1000;

      case ScaleUnit.Liter:
        unitPreGrams = 1000;

      case ScaleUnit.Ounce:
        unitPreGrams = 28.35;

      case ScaleUnit.Gram:
        unitPreGrams = 1;

      case ScaleUnit.Pound:
        unitPreGrams = 453.59;

      case ScaleUnit.Milliliter:
        unitPreGrams = 1;

      default:
    }

    return unitPreGrams;
  }
}
