import 'package:flutter/material.dart';

class PastNeedsWidget extends StatelessWidget {
  const PastNeedsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "If you haven't created any needs yet, create one and it will appear here.",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
