// ignore_for_file: comment_references

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/color.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../theme/theme.dart';

class DinasonaTextField extends StatelessWidget {
  const DinasonaTextField({
    required this.hintText,
    required this.controller,
    super.key,
    this.obscureText = false,
    this.errorText,
    this.errorColor = LightColor.inferno,
    this.hintColor = LightColor.graphite,
    this.backgroundColor = LightColor.moonstone,
    this.borderColor = LightColor.graphite,
    this.labelText,
    this.labelColor = LightColor.shadowed,
    this.textColor = LightColor.shadowed,
    this.hasVerticalMargin = false,
    this.suffixIcon,
    this.prefix,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.keyboardType,
    this.maxLength,
    this.onEnter,
    this.maxLines = 1,
  });

  /// Error text to display beneath the TextField.
  final String? errorText;

  /// Color of error text. Default is [LightColor.inferno].
  final Color errorColor;

  /// ObscureText for passwords.
  final bool obscureText;

  /// Hint text to display when no text has been input.
  final String? hintText;

  /// Color of error text. Default is [LightColor.amberglow].
  final Color hintColor;

  final Color backgroundColor;

  final Color borderColor;

  /// Label text to display above the TextField.
  final String? labelText;

  /// Color of label text. Default is [LightColor.shadowed].
  final Color labelColor;

  /// Color of the input text. Default is [LightColor.shadowed]
  final Color textColor;

  /// Whether to add vertical padding to the TextField.
  final bool hasVerticalMargin;

  /// Controller for this TextField.
  final TextEditingController? controller;

  /// A widget to be rendered at the end of the TextField.
  final Widget? suffixIcon;

  /// A widget to be rendered at the beginning of the TextField.
  final Widget? prefix;

  /// Input validator callback.
  final String? Function(String?)? validator;

  /// Auto validate mode.
  final AutovalidateMode autovalidateMode;

  /// Keyboard type.
  final TextInputType? keyboardType;

  /// On changed text callback.
  final void Function(String)? onChanged;

  /// On enter callback.
  final void Function(String?)? onEnter;

  final int? maxLength;

  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: hasVerticalMargin ? getRelativeHeight(10) : 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (labelText != null) SizedBox(height: getRelativeHeight(5)),
          if (labelText != null)
            Padding(
              padding: EdgeInsets.only(
                left: getRelativeWidth(5),
                bottom: getRelativeHeight(5),
              ),
              child: Text(
                labelText!,
                style: CustomTypography.fromColor(theme.amberglow).k24Bold,
              ),
            ),
          Card(
            shadowColor: Colors.transparent,
            margin: EdgeInsets.zero,
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(getRelativeWidth(16)),
              ),
              side: BorderSide(
                color: borderColor,
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.01,
                  horizontal: screenSize.width * 0.03,
                ),
                child: TextFormField(
                  maxLines: obscureText ? 1 : maxLines,
                  obscureText: obscureText,
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller,
                  style: TextStyle(color: textColor),
                  cursorColor: theme.graphite,
                  validator: validator,
                  autovalidateMode: autovalidateMode,
                  onChanged: onChanged,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  onFieldSubmitted: onEnter,
                  decoration: InputDecoration(
                    counterStyle: TextStyle(
                      color: theme.shadowed,
                    ),
                    isDense: true,
                    hintText: hintText,
                    hintStyle: TextStyle(color: hintColor),
                    border: InputBorder.none,
                    suffixIcon: suffixIcon,
                    prefixIcon: prefix,
                  ),
                ),
              ),
            ),
          ),
          if (errorText != null)
            SizedBox(
              height: getRelativeHeight(16),
              child: Text(
                errorText!,
                style: TextStyle(
                  color: errorColor,
                  fontSize: 13,
                ),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
