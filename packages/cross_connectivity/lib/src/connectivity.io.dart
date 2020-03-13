// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' show Platform;

import 'package:rxdart/rxdart.dart';

import 'core/connectivity_service.interface.dart';
import 'core/connectivity_service.linux.dart' as linux;
import 'core/connectivity_service.common.dart' as common;
import 'core/connectivity_service.windows.dart' as windows;

class Connectivity implements ConnectivityServiceInterface {
  /// Constructs a singleton instance of [Connectivity].
  factory Connectivity() {
    if (_singleton == null) {
      if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
        _singleton = Connectivity._(common.ConnectivityService());
      } else if (Platform.isWindows) {
        _singleton = Connectivity._(windows.ConnectivityService());
      } else if (Platform.isLinux) {
        _singleton = Connectivity._(linux.ConnectivityService());
      }
    }

    return _singleton;
  }
  const Connectivity._(this._connectivityService);
  static Connectivity _singleton;

  final ConnectivityServiceInterface _connectivityService;

  /// Fires whenever the connectivity state changes.
  ///
  /// Only shows whether the device is connected to the network or not.
  @override
  ValueStream<bool> get isConnected => _connectivityService.isConnected;

  /// Fires whenever the connectivity state changes.
  @override
  ValueStream<ConnectivityStatus> get onConnectivityChanged =>
      _connectivityService.onConnectivityChanged;

  /// Checks the connection status of the device.
  ///
  /// Do not use the result of this function to decide whether you can reliably
  /// make a network request. It only gives you the radio status.
  ///
  /// Instead listen for connectivity changes via [onConnectivityChanged] stream.
  @override
  Future<ConnectivityStatus> checkConnectivity() =>
      _connectivityService.checkConnectivity();

  /// Obtains the wifi name (SSID) of the connected network
  ///
  /// Please note that it DOESN'T WORK on emulators and web (returns null).
  ///
  /// From android 8.0 onwards the GPS must be ON (high accuracy)
  /// in order to be able to obtain the SSID.
  @override
  Future<String> getWifiName() => _connectivityService.getWifiName();

  /// Obtains the wifi BSSID of the connected network.
  ///
  /// Please note that it DOESN'T WORK on emulators and web (returns null).
  ///
  /// From Android 8.0 onwards the GPS must be ON (high accuracy)
  /// in order to be able to obtain the BSSID.
  @override
  Future<String> getWifiBSSID() => _connectivityService.getWifiBSSID();

  /// Obtains the IP address of the connected wifi network
  @override
  Future<String> getWifiIP() => _connectivityService.getWifiIP();

  @override
  void dispose() => _connectivityService.dispose();
}
