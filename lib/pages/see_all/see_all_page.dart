import 'package:flutter/material.dart';

import '../../model/need.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/need_card.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({
    required this.field,
    required this.donationsInField,
    super.key,
  });
  final AreaOfInterest field;
  final List<Need> donationsInField;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: field.title,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getRelativeWidth(15),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (final Need donation in donationsInField)
                NeedCard(need: donation),
            ],
          ),
        ),
      ),
    );
  }
}
