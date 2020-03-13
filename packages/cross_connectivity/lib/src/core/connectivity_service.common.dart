// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:connectivity/connectivity.dart';

import 'connectivity_service.interface.dart';

/// Discover network connectivity configurations: Distinguish between WI-FI
/// and cellular, check WI-FI status and more.
class ConnectivityService extends ConnectivityServiceInterface {
  /// Constructs a singleton instance of [ConnectivityService].
  ConnectivityService() : super() {
    void update(ConnectivityResult result) {
      final status = ConnectivityStatus.values[result.index];
      if (_onConnectivityChanged.value != status) {
        _onConnectivityChanged.add(status);
      }

      final isConnected = status != ConnectivityStatus.none;
      if (_isConnected.value != isConnected) {
        _isConnected.add(isConnected);
      }
    }

    _subscription = _connectivity.onConnectivityChanged.listen(update);
    _connectivity.checkConnectivity().then(update);
  }

  StreamSubscription _subscription;
  final _connectivity = Connectivity();
  final _isConnected = BehaviorSubject<bool>();
  final _onConnectivityChanged = BehaviorSubject<ConnectivityStatus>();

  /// Fires whenever the connectivity state changes.
  ///
  /// Only shows whether the device is connected to the network or not.
  @override
  ValueStream<bool> get isConnected => _isConnected;

  /// Fires whenever the connectivity state changes.
  @override
  ValueStream<ConnectivityStatus> get onConnectivityChanged =>
      _onConnectivityChanged;

  /// Checks the connection status of the device.
  ///
  /// Do not use the result of this function to decide whether you can reliably
  /// make a network request. It only gives you the radio status.
  ///
  /// Instead listen for connectivity changes via [onConnectivityChanged] stream.
  @override
  Future<ConnectivityStatus> checkConnectivity() async => ConnectivityStatus
      .values[(await _connectivity.checkConnectivity()).index];

  /// Obtains the wifi name (SSID) of the connected network
  ///
  /// Please note that it DOESN'T WORK on emulators and web (returns null).
  ///
  /// From android 8.0 onwards the GPS must be ON (high accuracy)
  /// in order to be able to obtain the SSID.
  @override
  Future<String> getWifiName() => _connectivity.getWifiName();

  /// Obtains the wifi BSSID of the connected network.
  ///
  /// Please note that it DOESN'T WORK on emulators and web (returns null).
  ///
  /// From Android 8.0 onwards the GPS must be ON (high accuracy)
  /// in order to be able to obtain the BSSID.
  @override
  Future<String> getWifiBSSID() => _connectivity.getWifiBSSID();

  /// Obtains the IP address of the connected wifi network
  @override
  Future<String> getWifiIP() => _connectivity.getWifiIP();

  @override
  void dispose() {
    _subscription?.cancel();
    if (_isConnected?.isClosed == false) {
      _isConnected?.close();
    }
    if (_onConnectivityChanged?.isClosed == false) {
      _onConnectivityChanged?.close();
    }
  }
}
