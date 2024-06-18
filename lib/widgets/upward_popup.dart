import 'package:flutter/material.dart';

class UpwardOverlay extends StatefulWidget {
  const UpwardOverlay({
    required this.title,
    required this.child,
    super.key,
    this.margin = EdgeInsets.zero,
    this.duration = const Duration(milliseconds: 500),
    this.height,
    this.color = Colors.white,
    this.menu,
    this.onMenu,
    this.headerColor = Colors.black,
  });
  final String title;
  final Widget child;
  final EdgeInsets margin;
  final Duration duration;
  final double? height;
  final Color color;
  final Icon? menu;
  final Color headerColor;
  final Function()? onMenu;

  @override
  State<UpwardOverlay> createState() => _UpwardOverlayState();
}

class _UpwardOverlayState extends State<UpwardOverlay>
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
      end: const Offset(0, 0),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    UpwardOverlayHeader(
                      title: widget.title,
                      headerColor: widget.headerColor,
                      onMenu: widget.onMenu,
                      menu: widget.menu,
                    ),
                    const Divider(),
                    widget.child,
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
    super.key,
    this.menu,
    this.onMenu,
  });
  final String title;
  final Icon? menu;
  final Color headerColor;
  final Function()? onMenu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
              icon: Icon(
                Icons.west,
                size: 28,
                color: headerColor,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: headerColor,
                ),
              ),
            ),
          ),
          if (onMenu != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: menu ?? const Icon(Icons.menu, size: 32),
                onPressed: onMenu,
              ),
            )
          else
            const SizedBox(height: 32, width: 56),
        ],
      ),
    );
  }
}
