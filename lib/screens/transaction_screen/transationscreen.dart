import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transactions/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

class Transaction_Screen extends StatelessWidget {
  const Transaction_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final _value = newList[index];
              return Slidable(
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 50,
                        child: Text(
                          parseDate(_value.date),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                        backgroundColor: _value.type == CategoryType.income
                            ? Colors.green
                            : Colors.red),
                    title: Text('RS ${_value.amount}'),
                    subtitle: Text(_value.category.name),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newList.length);
      },
    );
  }

  String parseDate(DateTime date) {
    final _day = DateFormat.d().format(date);
    final _month = DateFormat.MMM().format(date);
    return '${_day}\n${_month}';
  }
}
