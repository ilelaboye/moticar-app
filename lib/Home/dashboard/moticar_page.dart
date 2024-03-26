import 'package:flutter/material.dart';


class MoticarPage extends StatefulWidget {
  const MoticarPage({super.key});

  @override
  State<MoticarPage> createState() => _MoticarPageState();
}

class _MoticarPageState extends State<MoticarPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffEFF5F5),
      body: Center(
        child: Text('Moticar Page'),
      ),
    );
  }
}
