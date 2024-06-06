import 'package:flutter/material.dart';

import '../widgets/custom_scaffold.dart';
import '../widgets/story_popup.dart';

class TempHomePage extends StatelessWidget {
  const TempHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO replace this with the actual home page
    return CustomScaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('personal details page'),
          onPressed: () {
            showDialog<Widget>(
              context: context,
              builder: (BuildContext context) => const StoryPopup(),
            );
          },
        ),
      ),
    );
  }
}
