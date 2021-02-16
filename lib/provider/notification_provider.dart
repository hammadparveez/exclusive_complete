import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/notification_model.dart';
import 'package:sixvalley_ui_kit/data/repository/notification_repo.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepo notificationRepo;

  NotificationProvider({@required this.notificationRepo});

  List<NotificationModel> _notificationList = [];

  List<NotificationModel> get notificationList => _notificationList;
  void addNotification(Map<String, dynamic> map) {
    print("Notification is called $map");
    notificationRepo.addNotification(map);
  }

  void getNotifications() {
    final list = notificationRepo.listOfNotifications;
    print("List of Notifications ${list.first}");
  }

  void initNotificationList() async {
    if (_notificationList.length == 0) {
      _notificationList.clear();
      _notificationList.addAll(notificationRepo.getNotificationList());
      notifyListeners();
    }
  }
}
