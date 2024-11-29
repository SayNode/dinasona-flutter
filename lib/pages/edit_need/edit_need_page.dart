import 'package:flutter/material.dart';

import '../../model/need.dart';
import '../../widgets/custom_scaffold.dart';
import '../create_new_need/create_new_need.dart';

class EditNeedPage extends StatelessWidget {
  const EditNeedPage({super.key, this.need});

  final Need? need;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: CreateNewNeed(
        need: need,
      ),
    );
  }
}
