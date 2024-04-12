// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/app_providers.dart';
import '../../widgets/colors.dart';

class MoticarPage extends StatefulHookConsumerWidget {
  const MoticarPage({super.key});

  @override
  ConsumerState<MoticarPage> createState() => _MoticarPageState();
}

class _MoticarPageState extends ConsumerState<MoticarPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ref.read(profileProvider.notifier).getTechnicians();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);

    //

    DateTime now = DateTime.now();
    DateTime endOfYear = DateTime(now.year + 1, 1, 1);
    int remainingDays = endOfYear.difference(now).inDays;
    return const Scaffold(
      backgroundColor: AppColors.teal,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text(
                            "Welcome to Moticar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),

          

          //
        ],
      ),
    );
  }
}

 