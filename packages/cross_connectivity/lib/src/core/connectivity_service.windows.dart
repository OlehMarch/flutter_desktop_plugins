// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:rxdart/rxdart.dart';

import 'connectivity_service.interface.dart';

/// Discover network connectivity configurations: Distinguish between WI-FI
/// and cellular, check WI-FI status and more.
class ConnectivityService extends ConnectivityServiceInterface {
  /// Constructs a singleton instance of [ConnectivityService].
  const ConnectivityService() : super();

  /// Fires whenever the connectivity state changes.
  ///
  /// Only shows whether the device is connected to the network or not.
  @override
  ValueStream<bool> get isConnected => throw UnimplementedError();

  /// Fires whenever the connectivity state changes.
  @override
  ValueStream<ConnectivityStatus> get onConnectivityChanged =>
      throw UnimplementedError();

  /// Checks the connection status of the device.
  ///
  /// Do not use the result of this function to decide whether you can reliably
  /// make a network request. It only gives you the radio status.
  ///
  /// Instead listen for connectivity changes via [onConnectivityChanged] stream.
  @override
  Future<ConnectivityStatus> checkConnectivity() => throw UnimplementedError();

  /// Obtains the wifi name (SSID) of the connected network
  ///
  /// Please note that it DOESN'T WORK on emulators and web (returns null).
  ///
  /// From android 8.0 onwards the GPS must be ON (high accuracy)
  /// in order to be able to obtain the SSID.
  @override
  Future<String> getWifiName() => throw UnimplementedError();

  /// Obtains the wifi BSSID of the connected network.
  ///
  /// Please note that it DOESN'T WORK on emulators and web (returns null).
  ///
  /// From Android 8.0 onwards the GPS must be ON (high accuracy)
  /// in order to be able to obtain the BSSID.
  @override
  Future<String> getWifiBSSID() => throw UnimplementedError();

  /// Obtains the IP address of the connected wifi network
  @override
  Future<String> getWifiIP() => throw UnimplementedError();

  @override
  void dispose() => throw UnimplementedError();
}
