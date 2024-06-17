import 'package:flutter/material.dart';

import '../../widgets/custom_scaffold.dart';
import 'widgets/profile_widget.dart';

class DonorSettingsPage extends StatelessWidget {
  const DonorSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: Column(
        children: <Widget>[
          ProfileWidget(),
          Text('Donor Settings Page'),
        ],
      ),
    );
  }
}
