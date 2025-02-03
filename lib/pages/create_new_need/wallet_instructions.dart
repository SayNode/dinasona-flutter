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
  const InstructionsPage({
    required this.isDonation,
    super.key,
  });
  final bool isDonation;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    final CreateNewNeedController controller =
        Get.put(CreateNewNeedController(), tag: UniqueKey().toString());

    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(16)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Gap(getRelativeHeight(15)),
              Text(
                'Set up your wallet'.tr,
                style: CustomTypography.fromColor(theme.shadowed).k24Bold,
              ),
              Gap(getRelativeHeight(15)),
              NumberedInstructionsWidget(
                number: 1,
                text: isDonation
                    ? 'To donate and support people, you first need to add a wallet by creating or importing a wallet.'
                        .tr
                    : 'To publish a need and receive support, you first \nneed to add a wallet by creating or importing a wallet.'
                        .tr,
              ),
              Gap(getRelativeHeight(12)),
              NumberedInstructionsWidget(
                number: 2,
                text:
                    'Enter your existing seedphrase or save your new seed phrase to gain access to your wallet.'
                        .tr,
              ),
              Gap(getRelativeHeight(12)),
              NumberedInstructionsWidget(
                number: 3,
                text:
                    'If you are setting up a new wallet, enter the 3 seed words requested. For importing a wallet add your existing seed phrase consisting of 12 words.'
                        .tr,
              ),
              Gap(getRelativeHeight(12)),
              NumberedInstructionsWidget(
                number: 4,
                text: isDonation
                    ? 'Once your wallet is set up, you can donate to a need and support someone financially.'
                        .tr
                    : 'Once your wallet is set up, you can publish a need, someone will support you financially.'
                        .tr,
              ),
              Gap(getRelativeHeight(40)),
              DinasonaButton(
                text: 'Add wallet'.tr,
                onPressed: controller.getToWalletScreen,
                color: theme.amberglow,
              ),
              Gap(getRelativeHeight(20)),
            ],
          ),
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
