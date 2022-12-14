import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:malzama_app/src/features/home/presentation/state_provider/notifcation_state_provider.dart';
import '../../../Navigator/navigation_service.dart';
import '../../../Navigator/routes_names.dart';
import '../dialog_services/service_locator.dart';

class LocalNotificationService {
  // private default constructor
  LocalNotificationService._();

  // singleton
  static LocalNotificationService _instance = LocalNotificationService._();

  factory LocalNotificationService.getInstance() => _instance;

  FlutterLocalNotificationsPlugin notificationsPlugin;

  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iOSSettings;
  InitializationSettings initializationSettings;
  AndroidNotificationDetails androidNotificationDetails;
  IOSNotificationDetails iosNotificationDetails;
  NotificationDetails notificationDetails;

  // I don't know what is its useCase
  Future<void> _onDidReceiveLocalNotification(
      int x, String y, String z, String zz) async {
    // related to iOS
  }

  // called whenever the notification is tapped on
  Future _onSelectNotification(String payload) async {
    print('**************************************************');
    print('inside On select notificaiton');
    print('**************************************************');
    try {
      var stateProvider = locator.get<NotificationStateProvider>();
      stateProvider.setAsOpenedByID(json.decode(payload)['id']);

      NavigationService service = NavigationService.getInstance();
      print('********************************** this is the service $service');
      print(NavigationService.navigationKeys);
      print(service.currentIndex);
      print(NavigationService.navigationKeys[service.currentIndex]);
      NavigationService.navigationKeys[service.currentIndex].currentState
          .pushNamed(RouteNames.VIEW_LECTURE_DETAILS,
              arguments: json.decode(payload));
    } catch (err) {
      print('we have got an error');
      print(err.toString());
      throw err;
    }
  }

  Future<void> initialize() async {
    notificationsPlugin = new FlutterLocalNotificationsPlugin();
    androidInitializationSettings =
        new AndroidInitializationSettings('app_icon');
    iOSSettings = new IOSInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSSettings,
    );
    androidNotificationDetails = new AndroidNotificationDetails(
      "Channel_ID",
      "Channel title",
      "Channel body",
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'test',
    );
    iosNotificationDetails = new IOSNotificationDetails();

    notificationDetails = new NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    await notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  // show notification
  Future<void> showNotification(
      {int channelID, String title, String body, String payload}) async {
    await notificationsPlugin.show(channelID, title, body, notificationDetails,
        payload: payload);
  }
}
