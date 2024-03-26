import 'package:flutter/material.dart';

class SpendPage extends StatefulWidget {
  const SpendPage({super.key});

  @override
  State<SpendPage> createState() => _SpendPageState();
}

class _SpendPageState extends State<SpendPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffEFF5F5),
      body: Center(
        child: Text('Spend Page'),
      ),
    );
  }
}