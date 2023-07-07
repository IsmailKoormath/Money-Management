import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

class AddTranstactionScreen extends StatefulWidget {
  static const routeName = 'Add-transation';

  const AddTranstactionScreen({super.key});

  @override
  State<AddTranstactionScreen> createState() => _AddTranstactionScreenState();
}

class _AddTranstactionScreenState extends State<AddTranstactionScreen> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? _categoryID;

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'purpose',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Amount',
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final _selectedDateTemp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now(),
                );
                if (_selectedDateTemp == null) {
                  return;
                } else {
                  setState(() {
                    _selectedDate = _selectedDateTemp;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(_selectedDate == null
                  ? 'Select Date '
                  : _selectedDate.toString()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.income;
                            _categoryID = null;
                          });
                        }),
                    const Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.expense;
                            _categoryID = null;
                          });
                        }),
                    const Text('Expense'),
                  ],
                ),
              ],
            ),
            DropdownButton(
                hint: const Text('select Category'),
                value: _categoryID,
                items: (_selectedCategoryType == CategoryType.income
                        ? CategoryDB().incomeCategoryListListener
                        : CategoryDB().expenseCategoryListListener)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      _selectedCategoryModel = e;
                    },
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  setState(() {
                    _categoryID = selectedValue;
                  });
                }),
            ElevatedButton(onPressed: () {}, child: const Text('Submit')),
          ],
        ),
      )),
    );
  }
}
