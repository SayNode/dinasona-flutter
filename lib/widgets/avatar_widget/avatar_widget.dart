import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import 'controller/avatar_widget_controller.dart';

class AvatarWidget extends GetView<AvatarWidgetController> {
  const AvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    final UserStateService userStateService = Get.find<UserStateService>();
    return InkWell(
      onTap: controller.selectImage,
      child: Stack(
        children: <Widget>[
          Obx(
            () {
              return ClipOval(
                child: (userStateService.user.value.avatar.isNotEmpty)
                    ? Image.network(
                        userStateService.user.value.avatar,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) {
                          return Image.asset(
                            'assets/images/profile_picture_placeholder.png',
                            width: 100,
                            height: 100,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/images/profile_picture_placeholder.png',
                        width: 100,
                        height: 100,
                      ),
              );
            },
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
