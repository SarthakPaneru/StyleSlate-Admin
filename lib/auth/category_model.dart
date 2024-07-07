import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(CategoryModel(
        name: 'Haircut',
        iconPath: 'lib/assets/icons/haircut.svg',
        boxColor: const Color(0xff9DCEFF)));

    categories.add(CategoryModel(
        name: 'Beard Trims',
        iconPath: 'lib/assets/icons/beard.svg',
        boxColor: const Color(0xffEEA4CE)));

    categories.add(CategoryModel(
        name: 'Facial',
        iconPath: 'lib/assets/icons/facial.svg',
        boxColor: const Color(0xff9DCEFF)));

    categories.add(CategoryModel(
        name: 'Massage',
        iconPath: 'lib/assets/icons/massage.svg',
        boxColor: const Color(0xffEEA4CE)));

    return categories;
  }
}
