import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/notification_model.dart';

class NotificationRepo {
  final listOfNotifications = [];

  addNotification(Map<String, dynamic> map) {
    final model = NotificationModel(Icons.event_available,
        map["notification"]["body"], DateTime.now(), false,
        title: map["notification"]["title"]);
    listOfNotifications.add(model);
  }

  List<NotificationModel> getNotificationList() {
    return listOfNotifications;
    List<NotificationModel> notificationList = [
      NotificationModel(
          Icons.event_available,
          'Your order has been marked for delivery. Your order number HYR25142548. Thanks.',
          DateTime.now(),
          false),
      NotificationModel(
          Icons.wifi_tethering,
          'Your order has been marked for delivery. Your order number HYR25142548. Thanks.',
          DateTime.now(),
          false),
      NotificationModel(
          Icons.view_module,
          'Your order has been marked for delivery. Your order number HYR25142548. Thanks.',
          DateTime.now(),
          false),
      NotificationModel(
          Icons.settings_applications,
          'Your order has been marked for delivery. Your order number HYR25142548. Thanks.',
          DateTime.now(),
          true),
      NotificationModel(
          Icons.verified_user,
          'Your order has been marked for delivery. Your order number HYR25142548. Thanks.',
          DateTime.now(),
          true),
      NotificationModel(
          Icons.event_available,
          'Your order has been marked for delivery. Your order number HYR25142548. Thanks.',
          DateTime.now(),
          false),
      NotificationModel(
          Icons.wifi_tethering,
          'Your order has been marked for delivery. Your order number HYR25142548. Thanks.',
          DateTime.now(),
          false),
      NotificationModel(
          Icons.view_module,
          'Your order has been marked for delivery. Your order number HYR25142548. Thanks.',
          DateTime.now(),
          false),
      NotificationModel(
          Icons.settings_applications,
          'Your order has been marked for delivery. Your order number HYR25142548. Thanks.',
          DateTime.now(),
          true),
      NotificationModel(
          Icons.verified_user,
          'Your order has been marked for delivery. Your order number HYR25142548. Thanks.',
          DateTime.now(),
          true),
    ];
    return notificationList;
  }
}
