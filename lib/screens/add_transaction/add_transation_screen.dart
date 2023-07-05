import 'package:flutter/material.dart';

class AddTranstactionScreen extends StatelessWidget {
  static const routeName = 'Add-transation';

  const AddTranstactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text('add transaction'),
      ),
    );
  }
}
