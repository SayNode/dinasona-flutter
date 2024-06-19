import 'package:get/get.dart';

import '../model/need.dart';
import '../pages/home/widgets/select_need_fields_popup.dart';
import '../widgets/custom_popup.dart';
import '../widgets/story_popup.dart';

class PopupManager {
  static Future<void> openStoryPopup() async {
    await openCustomPopup<void>(
      const StoryPopup(),
    );
  }

  static Future<List<NeedField>?> openSelectNeedFieldsPopup(
    List<NeedField> initialSelectedNeedFields,
  ) async {
    return Get.dialog<List<NeedField>>(
      SelectNeedFieldsPopup(
        initialSelectedNeedFields: initialSelectedNeedFields,
      ),
    );
  }
}
