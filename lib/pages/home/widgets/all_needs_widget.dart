import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../util/popup_manager.dart';
import '../../../widgets/need_card.dart';

class TabNeedWidget extends StatelessWidget {
  const TabNeedWidget({
    required this.needs,
    super.key,
  });
  final RxList<Need> needs;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: <Widget>[
            if (needs.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "If you haven't created any needs yet, create one and it will appear here.",
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                shrinkWrap: true,
                itemCount: needs.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return NeedCard(
                    need: needs[index],
                    onCardClicked: () =>
                        PopupManager.openMyNeedPopup(needs[index]),
                  );
                },
              ),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
          ],
        ),
      ),
    );
  }
}
