import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';

class SettingsBar extends StatelessWidget {
  const SettingsBar({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });
  final String title;
  final IconData? icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all(theme.silvershine),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Icon(icon, color: theme.shadowed, size: 24),
            const Gap(12),
            Text(
              title,
              style: CustomTypography.fromColor(theme.shadowed).k16SemiBold,
            ),
          ],
        ),
      ),
    );
  }
}
