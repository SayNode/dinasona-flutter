import 'package:flutter/material.dart';

import '../theme/color.dart';
import '../theme/typography.dart';

class DinasonaButton extends StatelessWidget {
  const DinasonaButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.color = LightColor.ferngreen,
    this.textColor = LightColor.snowfall,
    this.expand = true,
    this.showForwardIcon = false,
    this.trailingWidget,
    this.fontSize,
    this.loading = false,
    this.locked = false,
    this.padding = const EdgeInsets.all(20),
  });

  final String text;
  final Color color;
  final void Function()? onPressed;
  final bool expand;
  final Color textColor;
  final bool showForwardIcon;
  final Widget? trailingWidget;
  final double? fontSize;
  final bool loading;
  final bool locked;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: locked ? LightColor.graphite : color,
          disabledBackgroundColor: locked ? LightColor.graphite : color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: loading || locked
            ? null
            : () {
                onPressed?.call();
              },
        child: Row(
          mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: screenSize.height * 0.02),
            if (showForwardIcon) SizedBox(width: (fontSize ?? 14) * 2),
            if (expand)
              Expanded(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTypography.fromColor(textColor).k14Reg,
                  maxLines: 1,
                ),
              )
            else
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTypography.fromColor(textColor).k14Reg,
                maxLines: 1,
              ),
            if (showForwardIcon) ...<Widget>[
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: textColor,
                size: fontSize ?? 14,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: textColor,
                size: fontSize ?? 14,
              ),
            ],
            if (trailingWidget != null) trailingWidget!,
            if (loading)
              SizedBox(
                width: screenSize.height * 0.02,
                height: screenSize.height * 0.02,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            else
              SizedBox(width: screenSize.height * 0.02),
          ],
        ),
      ),
    );
  }
}
