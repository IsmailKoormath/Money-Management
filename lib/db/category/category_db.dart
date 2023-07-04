import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunction {
  Future<List<CategoryModel>> getCatergories();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDB implements CategoryDbFunction {
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.add(value);
  }

  @override
  Future<List<CategoryModel>> getCatergories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }
}
