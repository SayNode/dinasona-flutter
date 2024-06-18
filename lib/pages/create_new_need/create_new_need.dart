import 'package:flutter/material.dart';

import '../../widgets/custom_scaffold.dart';

class CreateNewNeed extends StatelessWidget {
  const CreateNewNeed({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: Column(
        children: <Widget>[
          Text('Create New Need'),
        ],
      ),
    );
  }
}
