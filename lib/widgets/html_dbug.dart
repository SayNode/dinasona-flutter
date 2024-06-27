import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

//TODO: remove this page once the backend disables the debug mode
class HtmlDebug extends StatelessWidget {
  const HtmlDebug({required this.res, super.key});
  final String res;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Html(
          data: res,
        ),
      ),
    );
  }
}
