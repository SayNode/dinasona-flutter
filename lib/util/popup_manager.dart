import 'package:get/get.dart';

import '../model/need.dart';
import '../pages/home/widgets/currency_popup.dart';
import '../pages/home/widgets/my_need_popup.dart';
import '../pages/home/widgets/need_popup.dart';
import '../pages/home/widgets/select_need_fields_popup.dart';
import '../widgets/custom_popup.dart';
import '../widgets/dialogs/delete_account_dialog.dart';
import '../widgets/dialogs/logout_dialog.dart';
import '../widgets/popups/contact_us_popup.dart';
import '../widgets/popups/contribution_popup.dart';
import '../widgets/popups/draft_popup.dart';
import '../widgets/popups/need_fulfilled_popup.dart';
import '../widgets/popups/publish_popup.dart';
import '../widgets/popups/story_popup.dart';
import '../widgets/popups/wallet_info_popup.dart';

class PopupManager {
  static Future<void> openStoryPopup() async {
    await openCustomPopup<void>(
      const StoryPopup(),
    );
  }

  static Future<void> openDraftPopup() async {
    await openCustomPopup<void>(
      const DraftPopup(),
    );
  }

  static Future<void> openPublishPopup() async {
    await openCustomPopup<void>(
      const PublishPopup(),
    );
  }

  static Future<void> openLogoutPopup() async {
    await openCustomPopup<void>(
      const LogoutDialog(),
    );
  }

  static Future<void> openDeleteAccountPopup() async {
    await openCustomPopup<void>(
      const DeleteAccountDialog(),
    );
  }

  static Future<List<AreaOfInterest>?> openSelectAreasOfInterestPopup(
    List<AreaOfInterest> initialSelectedAreasOfInterest,
  ) async {
    return Get.dialog<List<AreaOfInterest>>(
      SelectAreasOfInterestPopup(
        initialSelectedAreasOfInterest: initialSelectedAreasOfInterest,
      ),
    );
  }

  static Future<List<AreaOfInterest>?> openNeedPopup(
    Need need,
  ) async {
    return Get.dialog<List<AreaOfInterest>>(
      NeedPopup(
        need: need,
      ),
    );
  }

  static Future<List<AreaOfInterest>?> openMyNeedPopup(
    Need need,
  ) async {
    return Get.dialog<List<AreaOfInterest>>(
      MyNeedPopup(
        need: need,
      ),
    );
  }

  static Future<List<AreaOfInterest>?> openCurrencyPopup(
    List<AreaOfInterest> initialSelectedAreasOfInterest,
  ) async {
    return Get.dialog<List<AreaOfInterest>>(
      const CurrencyPopup(),
    );
  }

  static Future<List<AreaOfInterest>?> openWalletInfoPopup(
    String title,
    String description,
  ) async {
    return Get.dialog(
      Walletinfopopup(title: title, description: description),
    );
  }

  static Future<void> openContactUsPopup(
    bool sendingMessageSuccess,
  ) async {
    await openCustomPopup<void>(
      ContactUsPopup(sendingMessageSuccess),
    );
  }

  static Future<void> openNeedFulfilledPopup() async {
    await openCustomPopup<void>(
      const NeedFulfilledPopup(),
    );
  }

  static Future<void> openContributionPopup() async {
    await openCustomPopup<void>(
      const ContributionPopup(),
    );
  }
}
