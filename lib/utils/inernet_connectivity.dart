import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityProvider() {
    checkConnection();
  }

  late StreamSubscription<ConnectivityResult> subscription;
  bool isConnected = false;

 void checkConnection() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        isConnected = true;
      } else if (result == ConnectivityResult.wifi) {
        isConnected = true;
      } else {
        isConnected = false;
      }
      notifyListeners();
    });

  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }
}
