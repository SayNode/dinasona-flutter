import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../util/image_loader.dart';

class AvatarWidgetController extends GetxController {
  Future<void> selectImage() async {
    //TODO: save image to backend
    await ImageLoader.pickImage(ImageSource.gallery);
  }
}
