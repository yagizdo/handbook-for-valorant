import 'package:flutter/material.dart';

class RanksScreen extends StatelessWidget {
  const RanksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('Ranks'),
      )),
    );
  }
}
