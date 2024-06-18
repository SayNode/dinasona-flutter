import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../theme/color.dart';
import '../theme/typography.dart';

class UpwardPopup extends StatefulWidget {
  const UpwardPopup({
    required this.title,
    this.child,
    super.key,
    this.margin = EdgeInsets.zero,
    this.duration = const Duration(milliseconds: 500),
    this.height,
    this.color = Colors.white,
    this.headerColor = Colors.black,
    this.onClose,
  });
  final String title;
  final Widget? child;
  final EdgeInsets margin;
  final Duration duration;
  final double? height;
  final Color color;
  final Color headerColor;
  final void Function()? onClose;

  @override
  State<UpwardPopup> createState() => _UpwardPopupState();
}

class _UpwardPopupState extends State<UpwardPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  late final double height;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: widget.duration);
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.decelerate,
      ),
    );
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SlideTransition(
          position: slideAnimation,
          child: Material(
            color: Colors.transparent,
            child: Material(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              color: LightColor.moonstone,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    UpwardOverlayHeader(
                      title: widget.title,
                      headerColor: widget.headerColor,
                      onClose: widget.onClose,
                    ),
                    widget.child ?? Container(),
                    const Gap(40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UpwardOverlayHeader extends StatelessWidget {
  const UpwardOverlayHeader({
    required this.title,
    required this.headerColor,
    this.onClose,
    super.key,
  });
  final String title;
  final Color headerColor;
  final void Function()? onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 28, 8, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: CustomTypography.fromColor(
                  LightColor.shadowed,
                ).k20Bold,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onClose,
              child: const Icon(
                Icons.close,
                size: 24,
                color: LightColor.shadowed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
