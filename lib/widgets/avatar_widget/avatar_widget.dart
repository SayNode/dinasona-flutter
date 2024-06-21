import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import 'controller/avatar_widget_controller.dart';

class AvatarWidget extends GetView<AvatarWidgetController> {
  const AvatarWidget({required this.imageUrl, super.key});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return InkWell(
      onTap: controller.selectImage,
      child: Stack(
        children: <Widget>[
          Container(
            child: (imageUrl.isNotEmpty)
                ? Image.network(
                    imageUrl,
                    height: 100,
                    width: 100,
                  )
                : Image.asset(
                    'assets/images/profile_picture_placeholder.png',
                    width: 100,
                    height: 100,
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(
              Icons.add_circle,
              color: theme.ferngreen,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
