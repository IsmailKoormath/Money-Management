import 'package:flutter/material.dart';

class Transaction_Screen extends StatelessWidget {
  const Transaction_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return const Card(
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                  radius: 50,
                  child: Text(
                    '12\nDEC',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  )),
              title: Text('1000000'),
              subtitle: Text('Travel'),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 30);
  }
}
