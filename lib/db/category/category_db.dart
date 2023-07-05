import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/screens/category_screen/income_category_list.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunction {
  Future<List<CategoryModel>> getCatergories();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDB implements CategoryDbFunction {
  ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.add(value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCatergories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCatergories();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    await Future.forEach(
        _allCategories,
        (CategoryModel category) => {
              if (category.type == CategoryType.income)
                {incomeCategoryListListener.value.add(category)}
              else
                {expenseCategoryListListener.value.add(category)}
            });

    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }
}
