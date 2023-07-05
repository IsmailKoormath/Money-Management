import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              return Card(
                child: ListTile(
                  title: Text('Income Category $index'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 10);
            },
            itemCount: 50,
          );
        });
  }
}
