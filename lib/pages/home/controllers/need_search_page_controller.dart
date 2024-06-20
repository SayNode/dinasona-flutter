import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../util/mock_data.dart';

class NeedSearchPageController extends GetxController {
  NeedSearchPageController(this.fields);
  final List<NeedField> fields;
  RxList<Need> needs = <Need>[].obs;

  @override
  Future<void> onInit() async {
    // TODO - Get needs from backend according to fields
    needs.addAll(
      MockData.needs.where(
        (Need e) => e.fields.toSet().intersection(fields.toSet()).isNotEmpty,
      ),
    );
    super.onInit();
  }
}
