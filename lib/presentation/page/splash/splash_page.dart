import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/colors.dart';
import '../../route/app_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => context.goNamed(
        RouteConstants.root,
        pathParameters: PathParameters().toMap(),
      ),
    );

    return const Scaffold(
      body: Center(
        child: Text(
          'Attendance Apps',
          style: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}