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

  checkConnection() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        isConnected = true;
        log("-----> connectivity is mobile <-----");
      } else if (result == ConnectivityResult.wifi) {
        isConnected = true;
        log("-----> connectivity is wifi <-----");

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
