import 'package:diabetes_enums/weightUnit.enum.dart';
import 'package:diabetes_models/food.model.dart';
import 'package:diabetes_models/weightScale.model.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:scale_module/helpers/foodScale.helper.dart';

class FoodsFactsHelper {
  // Change total carbs per weight
  // like if  flour contains on 38 carbs per 100 grams,
  // I i want eat 3.5 tablespoon ! how much carbs contains
  Food changeFactsPerWeight({
    required ScaleUnit unit,
    required double weight,
    required Food food,
  }) {
    // how many unit equals in grams
    // like 3.5 tablespoon = 49 grams
    final double weightPreGrams =
        FoodScaleHelper.weightToGrams(unit: unit, weight: weight);

    // get ratio weight per 100 grams
    // like in flour 38 carbs in 100 grams
    // so 3.5 tablespoon = 49 grams
    // so 49 / 100 grams  =  0.49 ratio
    final double ratio = (weightPreGrams / food.toGrams);

    // get carbs per ratio
    // 0.49 ratio * 38 carbs in 100 grams
    // will give us 18.62
    return Food(
      id: food.id,
      name: food.name,
      by: food.by,
      rate: food.rate,
      ingredients: food.ingredients,
      instructions: food.instructions,
      photoUrl: food.photoUrl,
      tipsAndTricks: food.tipsAndTricks,
      type: food.type,
      uid: food.uid,

      // reCalculating carbs with new ratio
      carbs: (food.carbs.isNaN)
          ? 0.0
          : double.parse((food.carbs * ratio).toStringAsFixed(1)),

      // reCalculating calories with new ratio
      calories: (food.calories == null || food.calories!.isNaN)
          ? 0.0
          : double.parse((food.calories! * ratio).toStringAsFixed(1)),

      // reCalculating fat with new ratio
      fat: (food.fat == null || food.fat!.isNaN)
          ? 0.0
          : double.parse((food.fat! * ratio).toStringAsFixed(1)),

      // reCalculating protein with new ratio
      protein: (food.protein == null || food.protein!.isNaN)
          ? 0.0
          : double.parse((food.protein! * ratio).toStringAsFixed(1)),

      scale: WeightScale(unit: unit, weight: weight),
      toGrams: weightPreGrams,
    );
  }

  // get total of carbs in my meal
  double totalCarbsInMeal(List<Food> meal) => double.parse(meal
      .map((f) => f.carbs)
      .fold<double>(0, (a, b) => a + b)
      .toStringAsFixed(1));

  // get total of fat in my meal
  double totalFatInMeal(List<Food> meal) => double.parse(meal
      .map((f) => f.fat ?? 0.0)
      .fold<double>(0, (a, b) => a + b)
      .toStringAsFixed(1));

  // // get total of fiber in my meal
  // double totalFiberInMeal(List<Dish> meal) => double.parse(meal
  //     .map((f) => f?.fiber ?? 0.0)
  //     .fold<double>(0, (a, b) => a + b)
  //     .toStringAsFixed(1));

  // get total of protein in my meal
  double totalProteinInMeal(List<Food> meal) => double.parse(meal
      .map((f) => f.protein ?? 0.0)
      .fold<double>(0, (a, b) => a + b)
      .toStringAsFixed(1));

  // // get total of carbs in my meal
  // double totalCaloriesInMeal(List<Dish> meal) => double.parse(meal
  //     .map((f) => f.calories ?? 0.0)
  //     .fold<double>(0, (a, b) => a + b)
  //     .toStringAsFixed(1));

  // // get total of carbs in my meal
  // double totalGIInMeal(List<Dish> meal) => double.parse(meal
  //     .map((f) => f?.gi ?? 0.0)
  //     .fold<double>(0, (a, b) => a + b)
  //     .toStringAsFixed(1));

  // get total of carbs in my meal
  double totalGramsInMeal(List<Food> meal) => double.parse(meal
      .map((f) => f.toGrams)
      .fold<double>(0, (a, b) => a + b)
      .toStringAsFixed(1));

  // // get total of carbs in my meal
  // double totalGLInMyMeal(List<Dish> meal) => double.parse(meal
  //     .map((f) => f?.gl ?? 0.0)
  //     .fold<double>(0, (a, b) => a + b)
  //     .toStringAsFixed(1));

  // get how much insulins dose in meal
  double totalInsulinDoseToCoverageCarbsInMeal({
    required double totalCarbs,
    required double medicalCaseCarbsRatio,
  }) {
    // condition check
    if (totalCarbs == 0) return 0;
    if (medicalCaseCarbsRatio == 0) return 0;

    // return insulin dose
    return double.parse(
        (totalCarbs / medicalCaseCarbsRatio).toStringAsFixed(1));
  }

  double calculateGlycemicLoad({num? carbs, num? gi}) {
    // properties
    double payload = 0.0;

    // skip
    if (carbs == null || gi == null) return payload;

    // else
    payload = (gi * carbs) / 100;

    return double.parse(payload.toStringAsFixed(1));
  }

  // check if this food  will takes more  time to digestion
  static isSlowDigestion({double? fat, double? protein}) {
    if (fat == null && protein == null) return false;

    if (fat!.isNaN && protein!.isNaN) return false;

    if (fat >= 15 || protein! >= 20) return true;

    return false;
  }

  double calculateCalories({
    double? carbs,
    double? fat,
    double? protein,
  }) {
    // properties
    double payload = 0.0;

    // skip
    if (carbs != null && !carbs.isNaN) payload = (carbs * 4.2) + payload;
    if (protein != null && !protein.isNaN) payload = (protein * 4.2) + payload;
    if (fat != null && !fat.isNaN) payload = (fat * 9) + payload;

    // return
    return double.parse(payload.toStringAsFixed(1));
  }

  // double mergeFibersAndCarbs({
  //   double carbs,
  //   double fibers,
  // }) {

  //   // properties
  //   double payload = 0.0;

  //   // if fibers null rerun carbs only
  //   if (fibers != null && !fibers.isNaN) payload = carbs;

  //   // if fibers less then 5 return carbs only
  //   if (fibers <= 5) payload = carbs;

  //   // if fibers bigger than 5, divided on 2 and add with carbs
  //   if (fibers > 5) payload = carbs + (fibers * 0.5);

  //   // return
  //   return double.parse(payload.toStringAsFixed(1));
  // }

  // convert list of ingredients to string
  String ingredientsToStringWithWeight(List<Food> ingredients) => ingredients
      .map(
          (e) => '${e.scale.weight} ${describeEnum(e.scale.unit).tr} ${e.name}')
      .toString()
      .replaceFirst('(', '')
      .replaceFirst(')', '');

  // convert list of ingredients to string
  String ingredientsToString(List<Food> ingredients) => ingredients
      .map((e) => e.name)
      .toString()
      .replaceFirst('(', '')
      .replaceFirst(')', '');
}
