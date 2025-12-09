import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/constants/enums.dart';

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatus lastResult = ConnectivityStatus.notDetermined;

  ConnectivityStatusNotifier() : super(ConnectivityStatus.notDetermined) {
    Connectivity().onConnectivityChanged.listen((results) {
      final connected = results.any(
        (r) =>
            r == ConnectivityResult.mobile ||
            r == ConnectivityResult.wifi ||
            r == ConnectivityResult.ethernet ||
            r == ConnectivityResult.vpn,
      );

      final newState =
          connected
              ? ConnectivityStatus.isConnected
              : ConnectivityStatus.isDisconnected;

      if (newState != lastResult) {
        lastResult = newState;
        state = newState;
      }
    });
  }
}

final connectivityStatusProvider =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>((
      ref,
    ) {
      return ConnectivityStatusNotifier();
    });
