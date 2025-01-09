import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class ImageComponentWidget extends StatelessWidget {
  const ImageComponentWidget({
    required this.onTap,
    this.file,
    super.key,
  });

  final void Function()? onTap;
  final File? file;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: getRelativeHeight(200),
        width: getRelativeWidth(400),
        decoration: BoxDecoration(
          // color: theme.shadowed.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.shadowed.withAlpha(77),
          ),
          image: file == null
              ? null
              : DecorationImage(
                  image: FileImage(
                    file!,
                  ),
                  fit: BoxFit.contain,
                ),
        ),
        child: file == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Add photo',
                      style: CustomTypography.fromColor(theme.graphite).k14Reg,
                    ),
                    Icon(
                      Icons.add,
                      color: theme.graphite,
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
