import 'dart:async';

enum ConnectivityStatus {
  connected,
  disconnected,
  unknown,
}

abstract class ConnectivityService {
  Stream<ConnectivityStatus> get connectivityStream;
  
  ConnectivityStatus get currentStatus;
  
  bool get isConnected;
  
  Future<void> initialize();
  
  Future<void> dispose();
  
  Future<ConnectivityStatus> checkConnectivity();
}