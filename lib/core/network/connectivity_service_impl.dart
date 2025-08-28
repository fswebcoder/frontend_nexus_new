import 'dart:async';
import 'dart:io' show InternetAddress;

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
  
  ConnectivityStatus _currentStatus = ConnectivityStatus.unknown;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _debounceTimer;
  bool _isInitialized = false;

  @override
  Stream<ConnectivityStatus> get connectivityStream =>
      _connectivityController.stream;

  @override
  ConnectivityStatus get currentStatus => _currentStatus;

  @override
  bool get isConnected => _currentStatus == ConnectivityStatus.connected;

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      await checkConnectivity();
      _connectivitySubscription = _connectivity.onConnectivityChanged
          .listen((List<ConnectivityResult> results) {
        _debounceConnectivityChange(results);
      });
      
      _isInitialized = true;
    } catch (e) {
      _updateStatus(ConnectivityStatus.unknown);
    }
  }

  @override
  Future<void> dispose() async {
    _debounceTimer?.cancel();
    await _connectivitySubscription?.cancel();
    await _connectivityController.close();
    _isInitialized = false;
  }

  @override
  Future<ConnectivityStatus> checkConnectivity() async {
    try {
      final List<ConnectivityResult> connectivityResults =
          await _connectivity.checkConnectivity();
      
      await _handleConnectivityChange(connectivityResults);
      return _currentStatus;
    } catch (e) {
      _updateStatus(ConnectivityStatus.unknown);
      return ConnectivityStatus.unknown;
    }
  }

  void _debounceConnectivityChange(List<ConnectivityResult> results) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
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
      _updateStatus(ConnectivityStatus.unknown);
    }
  }

  Future<bool> _hasInternetConnection() async {
    try {
      const testUrls = [
        'https://www.google.com/generate_204', 
        'https://httpbin.org/status/200',      
        'https://jsonplaceholder.typicode.com/posts/1',
      ];

      if (kIsWeb) {
        return await _testHttpConnectivity(testUrls);
      }
      
      // Solo intentar DNS lookup en plataformas nativas (no web)
      if (!kIsWeb) {
        try {
          final result = await InternetAddress.lookup('8.8.8.8')
              .timeout(const Duration(seconds: 2));
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            return true;
          }
        } catch (e) {
          debugPrint('DNS lookup failed, trying HTTP: $e');
        }
      }
      
      return await _testHttpConnectivity(testUrls);
    } catch (e) {
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
        continue;
      }
    }
    return false;
  }

  void _updateStatus(ConnectivityStatus status) {
    if (_currentStatus != status) {
      _currentStatus = status;
      _connectivityController.add(status);
    }
  }
}