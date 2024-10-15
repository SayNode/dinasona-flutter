import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/util.dart';

class HeaderAndSubHeader extends StatelessWidget {
  const HeaderAndSubHeader({
    required this.header,
    required this.subHeader,
    this.isCentered = false,
    super.key,
  });
  final String header;
  final String subHeader;
  final bool isCentered;
  @override
  Widget build(BuildContext context) {
    final CustomTheme dinasonaTheme = ThemeService().theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Gap(20),
        Row(
          children: <Widget>[
            Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () => Get.back<void>(),
                customBorder: const CircleBorder(),
                child: const Icon(
                  Icons.chevron_left,
                  size: 32,
                ),
              ),
            ),
            const Gap(4),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(
                  right: getRelativeWidth(10),
                ),
                child: AutoSizeText(
                  header,
                  maxLines: 2,
                  style: CustomTypography.fromColor(
                    dinasonaTheme.shadowed,
                  ).k36Bold,
                  textAlign: isCentered ? TextAlign.center : TextAlign.start,
                ),
              ),
            ),
          ],
        ),
        const Gap(8),
        AutoSizeText(
          subHeader,
          maxLines: 2,
          style: CustomTypography.fromColor(
            dinasonaTheme.shadowed,
          ).k16Reg,
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
        ),
      ],
    );
  }
}
