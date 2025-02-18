/* import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'logger_service.dart';
import 'user_state_service.dart';

enum AnnouncementTopicTypes {
  topicOne,
  topic2,
}

class MessagingService extends GetxService {
  FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  LoggerService loggerService = Get.find<LoggerService>();

  Future<void> subscribe(AnnouncementTopicTypes topic) async {
    //todo
    // await _messaging.subscribeToTopic(topic.toString());
  }

  Future<void> unsubscribe(AnnouncementTopicTypes topic) async {
    //todo
    // await _messaging.unsubscribeFromTopic(topic.toString());
  }

  Future<bool> areNotificationsAuthorized() async {
    final NotificationSettings settings =
        await _messaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<MessagingService> init() async {
    loggerService.log('MessagingService - initializing ...');
    // Check for APNS on iOS
    if (GetPlatform.isIOS) {
      if (await _messaging.getAPNSToken() == null) {
        await Future<void>.delayed(const Duration(seconds: 3));
        if (await _messaging.getAPNSToken() == null) {
          loggerService.log("Still can't get APNS token, after delay.");
          return this;
        }
      }
    }

    final NotificationSettings settings = await _messaging.requestPermission();
    loggerService.log(
      'MessagingService - User granted permission: ${settings.authorizationStatus}',
    );

    String? token;
    for (int i = 0; i < 10; i++) {
      try {
        token = await _messaging.getToken();
        break; // Exit the loop if successful
      } catch (e) {
        if (i == 9) {
          rethrow; // TODO:Rethrow the exception if it's the last attempt for now. We should handle this in a better way later.
        }
        await Future<dynamic>.delayed(const Duration(milliseconds: 500));
      }
    }

    loggerService.log('MessagingService - token: $token');
    if (token != null && token.isNotEmpty) {
      Get.find<UserStateService>().notificationToken = token;
    }

    await setupInteractedMessage();

    try {
      await notificationPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('ic_notification'),
          iOS: DarwinInitializationSettings(),
        ),
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveNotificationResponse,
      );
    } catch (e) {
      loggerService.log('MessagingService Error on init', error: e);
    }

    loggerService.log('MessagingService - done.');
    return this;
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) {
    loggerService.log(
      'onDidReceiveNotificationResponse - ${response.payload} - ${response.id} - ${response.input}',
    );
    if (response.payload != null) {
      // Navigate to the specified page based on the notification type
      //Get.find<RoutingService>().to(response.payload);
    } else {
      loggerService.log('Clicked notification, but no route was specified.');
    }
  }

  void onDidReceiveBackgroundNotificationResponse(
    NotificationResponse response,
  ) {
    loggerService.log(
      'onDidReceiveBackgroundNotificationResponse - ${response.payload} - ${response.id} - ${response.input}',
    );
    if (response.payload != null) {
      // Navigate to the specified page based on the notification type
      //Get.find<RoutingService>().to(response.payload);
    } else {
      loggerService.log('Clicked notification, but no route was specified.');
    }
  }

  Future<String?> getInitialRouteName() async {
    final RemoteMessage? message = await getInitialMessage();
    if (message != null) {
      if (message.data['route'] != null) {
        final String? route = message.data['route'] as String?;
        //final routeName = _getRouteNameForNotificationType(route);
        return route;
      } else {
        loggerService.log('MessagingService - No notification type specified');
      }
    } else {
      loggerService.log('MessagingService - No initial message');
    }
    return null;
  }

  Future<RemoteMessage?> getInitialMessage() async {
    return FirebaseMessaging.instance.getInitialMessage();
  }

  Future<void> setupInteractedMessage() async {
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
    );
    await notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// FOR BACKGROUND MESSAGES
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    /// FOR FOREGROUND MESSAGES
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      loggerService
          .log('MessagingService - notification for foreground received!');
      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = message.notification?.android;
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (message.data['pop_up'] != null) {
        // Show local in-app notification
        // TODO
        //PopupManager.
      } else if (notification != null && android != null) {
        notificationPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel', // id
              'High Importance Notifications', // title
              importance: Importance.max,
              icon: 'ic_notification',
            ),
            iOS: DarwinNotificationDetails(),
          ),
          payload: message.data['route'] as String?,
        );
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    loggerService.log('MessagingService - message: ${message.data}');
    if (message.data['route'] != null) {
      final String? route = message.data['route'] as String?;
      //final routeName = _getRouteNameForNotificationType(route);
      if (route != null) {
        // Navigate to the specified page based on the notification type
        //Get.toNamed(routeName);
        //Get.find<RoutingService>().to(route);
      } else {
        loggerService
            .log('MessagingService - Unknown notification type: $route');
      }
    } else {
      loggerService.log('MessagingService - No notification type specified');
    }
  }

//route names that are to be used for push notifications need to be added here as well as in main.dart settings can be removed later its just to test
  /*String? _getRouteNameForNotificationType(String? notificationType) {
    switch (notificationType) {
      case 'settings':
        return '/settings';
      case 'home':
        return '/home';
      case 'profile':
        return '/profile';
      default:
        return '/';
    }
  }*/

//   Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     Constants.logger.log("MessagingService - handling a background message");
//     Constants.logger.log("MessagingService - message: ${message.data}");
//   }
}
 */
