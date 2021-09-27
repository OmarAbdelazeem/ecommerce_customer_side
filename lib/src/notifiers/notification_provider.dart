import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier {
  RemoteMessage? _initialMessage;

  set setInitialMessage(RemoteMessage? value) {
    _initialMessage = value;
    notifyListeners();
  }

  get initialMessage => _initialMessage;
}
