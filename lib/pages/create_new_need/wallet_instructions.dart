import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';
import 'controller/create_new_need_controller.dart';

class InstructionsPage extends GetView<CreateNewNeedController> {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return CustomScaffold(
      appBarTitle: '',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(16)),
        child: Column(
          children: <Widget>[
            Gap(getRelativeHeight(15)),
            Text(
              'Set up Instructions'.tr,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            Gap(getRelativeHeight(15)),
            NumberedInstructionsWidget(
              number: 1,
              text:
                  'To publish a need and receive support, you first \nneed to set up a wallet.'
                      .tr,
            ),
            Gap(getRelativeHeight(12)),
            NumberedInstructionsWidget(
              number: 2,
              text: "Press 'Create wallet'".tr,
            ),
            Gap(getRelativeHeight(12)),
            NumberedInstructionsWidget(
              number: 3,
              text:
                  "'Save your seed phrase': Write it down on paper \nand keep it safe—you'll need it in the future"
                      .tr,
            ),
            Gap(getRelativeHeight(12)),
            NumberedInstructionsWidget(
              number: 4,
              text: "Enter the '3 seed words' requested".tr,
            ),
            Gap(getRelativeHeight(12)),
            NumberedInstructionsWidget(
              number: 5,
              text:
                  'Once your wallet is set up, you can publish a need, and someone will support you financially.'
                      .tr,
            ),
            const Spacer(),
            DinasonaButton(
              text: 'Create wallet'.tr,
              onPressed: () => controller.getToCreateWalletScreen(),
              color: theme.amberglow,
            ),
            Gap(getRelativeHeight(50)),
          ],
        ),
      ),
    );
  }
}

class NumberedInstructionsWidget extends StatelessWidget {
  const NumberedInstructionsWidget({
    required this.number,
    required this.text,
    super.key,
  });

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return Row(
      children: <Widget>[
        Container(
          width: 33,
          height: 33,
          decoration: BoxDecoration(
            color: theme.amberglow,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: GoogleFonts.sourceSans3(
                color: theme.moonstone,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Gap(getRelativeWidth(12)),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: CustomTypography.fromColor(theme.shadowed).k16Reg,
              children: _buildTextSpans(text, theme),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to parse and format text
  List<TextSpan> _buildTextSpans(String text, CustomTheme theme) {
    final List<TextSpan> spans = <TextSpan>[];
    final RegExp regex =
        RegExp("'(.*?)'"); // Matches text between single quotes
    int lastMatchEnd = 0;

    // Iterate over all matches
    for (final RegExpMatch match in regex.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }
      spans.add(
        TextSpan(
          text: match.group(1), // Text between quotes
          style: GoogleFonts.sourceSans3(
            color: theme.shadowed,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
      lastMatchEnd = match.end;
    }

    // Add any remaining text after the last match
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }
}
