import 'package:flutter/material.dart';

import '../../widgets/custom_scaffold.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Image.asset(
          'assets/images/world_image.png',
          scale: 2,
        ),
      ),
    );
  }
}
