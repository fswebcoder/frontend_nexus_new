import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'connectivity_service.dart';

@LazySingleton(as: ConnectivityService)
class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<ConnectivityStatus> _connectivityController =
      StreamController<ConnectivityStatus>.broadcast();
  
  ConnectivityStatus _currentStatus = ConnectivityStatus.connected;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _debounceTimer;

  @override
  Stream<ConnectivityStatus> get connectivityStream =>
      _connectivityController.stream;

  @override
  ConnectivityStatus get currentStatus => _currentStatus;

  @override
  bool get isConnected => _currentStatus == ConnectivityStatus.connected;

  @override
  Future<void> initialize() async {
    _connectivityController.add(_currentStatus);
    
    await checkConnectivity();
        _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _debounceConnectivityChange(results);
    });
  }

  @override
  Future<void> dispose() async {
    _debounceTimer?.cancel();
    await _connectivitySubscription?.cancel();
    await _connectivityController.close();
  }

  @override
  Future<ConnectivityStatus> checkConnectivity() async {
    try {
      final List<ConnectivityResult> connectivityResults =
          await _connectivity.checkConnectivity();
      
      await _handleConnectivityChange(connectivityResults);
      return _currentStatus;
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
      _updateStatus(ConnectivityStatus.unknown);
      return ConnectivityStatus.unknown;
    }
  }

  void _debounceConnectivityChange(List<ConnectivityResult> results) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _handleConnectivityChange(results);
    });
  }

  Future<void> _handleConnectivityChange(
      List<ConnectivityResult> results) async {
    try {
      if (results.contains(ConnectivityResult.none)) {
        _updateStatus(ConnectivityStatus.disconnected);
        return;
      }

      final hasInternetConnection = await _hasInternetConnection();
      _updateStatus(hasInternetConnection
          ? ConnectivityStatus.connected
          : ConnectivityStatus.disconnected);
    } catch (e) {
      debugPrint('Error handling connectivity change: $e');
      _updateStatus(ConnectivityStatus.unknown);
    }
  }


  Future<bool> _hasInternetConnection() async {
    try {
      final testUrls = [
        'https://www.google.com/generate_204', 
        'https://httpbin.org/status/200',      
        'https://jsonplaceholder.typicode.com/posts/1',
      ];

      if (kIsWeb) {
        return await _testHttpConnectivity(testUrls);
      }
      
      try {
        if (Platform.isAndroid || Platform.isIOS) {
          final result = await InternetAddress.lookup('8.8.8.8')
              .timeout(const Duration(seconds: 2));
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            return true;
          }
        }
      } catch (e) {
        debugPrint('DNS lookup failed, trying HTTP: $e');
      }
      
      return await _testHttpConnectivity(testUrls);
    } catch (e) {
      debugPrint('Internet connection test failed: $e');
      return false;
    }
  }

  Future<bool> _testHttpConnectivity(List<String> testUrls) async {
    for (String url in testUrls) {
      try {
        final response = await http.get(Uri.parse(url))
            .timeout(const Duration(seconds: 3));
        
        if (response.statusCode >= 200 && response.statusCode < 400) {
          return true;
        }
      } catch (e) {
        debugPrint('HTTP test failed for $url: $e');
        continue;
      }
    }
    return false;
  }

  /// Actualiza el estado y notifica a los listeners
  void _updateStatus(ConnectivityStatus status) {
    if (_currentStatus != status) {
      debugPrint('Connectivity status changed: $_currentStatus -> $status');
      _currentStatus = status;
      _connectivityController.add(status);
    }
  }
}