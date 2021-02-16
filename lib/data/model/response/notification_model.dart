import 'package:flutter/material.dart';

class NotificationModel {
  IconData _icon;
  String _message;
  DateTime _dateTime;
  bool _isSeen;
  String title;
  String data;

  NotificationModel(this._icon, this._message, this._dateTime, this._isSeen,
      {this.title, this.data});

  bool get isSeen => _isSeen;
  DateTime get dateTime => _dateTime;
  String get message => _message;
  IconData get icon => _icon;
}
