import 'package:flutter/material.dart';
import 'package:money_management/screens/Home_screen/widgets/bottom_navigation.dart';
import 'package:money_management/screens/category_screen/add_category_popup.dart';
import 'package:money_management/screens/category_screen/category_screen.dart';
import 'package:money_management/screens/transaction_screen/transationscreen.dart';

class Home_screen extends StatelessWidget {
  Home_screen({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    Transaction_Screen(),
    Category_Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Money Management'),
        centerTitle: true,
      ),
      bottomNavigationBar: const Bottom_Navigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (BuildContext context, int updatedIndex, _) {
          return _pages[updatedIndex];
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('add transaction');
          } else {
            print('add category');
            showCategoryAddPopup(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
