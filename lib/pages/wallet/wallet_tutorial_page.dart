import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../widgets/custom_scaffold.dart';

class WalletTutorialPage extends StatelessWidget {
  const WalletTutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      appBarTitle: 'Wallet Tutorial',
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TutorialExpansionTile(
              title: '1. How to connect a wallet',
              tutorialTextContent:
                  'Before you can start donating / receiving funds, you need to connect a wallet. You can either import an existing wallet or create a new one. For this you can use the two buttons on the top of the screen.\n\n- Continue with step 2 if you want to create a wallet.\n- Continue with step 4 if you want to import an existing wallet.',
              image: 'wallet_overview',
            ),
            TutorialExpansionTile(
              title: '2. How to create a wallet',
              tutorialTextContent:
                  "Every wallet has a unique seed phrase that is used to recover the wallet in case you lose access to it. Make sure to write down the seed phrase and store it in a safe place. If you lose access to your wallet and don't have the seed phrase, you will lose access to your funds.\n\nOnce you have written down the seed phrase, you can continue with step 3.\n\nIMPORTANT: The seed phrase in the image is not a real seed phrase. Do not use it to recover a wallet.",
              image: 'wallet_creation',
            ),
            TutorialExpansionTile(
              title: '3. Confirm your seed phrase',
              tutorialTextContent:
                  'Now is the time to confirm your seed phrase. You will be asked to enter the words in the correct order. Make sure to double check the words and the order. If you make a mistake, you will not be able to access your wallet.\n\nOnce you have confirmed your seed phrase, you can continue with step 5.\n\nIMPORTANT: The seed phrase in the image is not a real seed phrase. Do not use it to recover a wallet.',
              image: 'wallet_confirm',
            ),
            TutorialExpansionTile(
              title: '4. Import a wallet',
              tutorialTextContent:
                  'If you already have a wallet and want to import it, you can do so by entering the seed phrase. Make sure to enter the seed phrase correctly. If you make a mistake, you will not be able to access your wallet.\n\nOnce you have entered the seed phrase, you can continue with step 5.',
              image: 'wallet_import',
            ),
            TutorialExpansionTile(
              title: '5. Understand your wallet',
              tutorialTextContent:
                  'Now that you have created or imported a wallet, you can start using it. You can send and receive funds, check your balance, and view your transaction history. Make sure to keep your seed phrase safe and never share it with anyone.',
              image: 'wallet_connected',
            ),
            TutorialExpansionTile(
              title: '6. Send and receive funds',
              tutorialTextContent:
                  'To send funds outside of needs, you can click on the send button and enter the invoice of the recipient.\n\nTo receive funds outside of needs, you need to press the "receive" button and follow the instructions there.',
              image: 'receive_send',
            ),
          ],
        ),
      ),
    );
  }
}

class TutorialExpansionTile extends StatelessWidget {
  const TutorialExpansionTile({
    required this.title,
    required this.tutorialTextContent,
    required this.image,
    super.key,
  });

  final String title;
  final String tutorialTextContent;
  final String image;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return ExpansionTile(
      title: Text(
        title.tr,
        style: CustomTypography.fromColor(theme.shadowed).k24Bold,
      ),
      children: <Widget>[
        ListTile(
          visualDensity: VisualDensity.compact,
          dense: true,
          title: Text(
            tutorialTextContent.tr,
            style: CustomTypography.fromColor(theme.shadowed).k16Reg,
          ),
        ),
        const Divider(),
        Image.asset('assets/images/tutorial/$image.jpg'),
      ],
    );
  }
}
