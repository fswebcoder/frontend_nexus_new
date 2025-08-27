import 'dart:async';

import 'package:injectable/injectable.dart';

import '../network/connectivity_service.dart';

/// Servicio global de conectividad que puede ser accedido desde cualquier parte de la app
/// Proporciona una interfaz simple para consultar el estado de conectividad
@LazySingleton()
class GlobalConnectivityService {
  final ConnectivityService _connectivityService;
  
  static GlobalConnectivityService? _instance;
  
  GlobalConnectivityService(this._connectivityService);
  
  /// Instancia singleton para acceso global
  static GlobalConnectivityService get instance {
    if (_instance == null) {
      throw Exception(
        'GlobalConnectivityService no ha sido inicializado. '
        'Llama a initialize() primero.'
      );
    }
    return _instance!;
  }
  
  /// Inicializa el servicio global
  static Future<void> initialize(GlobalConnectivityService service) async {
    _instance = service;
    await service._connectivityService.initialize();
  }

  /// Stream que emite cambios en el estado de conectividad
  Stream<ConnectivityStatus> get connectivityStream =>
      _connectivityService.connectivityStream;

  /// Estado actual de conectividad
  ConnectivityStatus get currentStatus => _connectivityService.currentStatus;

  /// Verifica si hay conexión a internet
  bool get isConnected => _connectivityService.isConnected;
  
  /// Verifica si NO hay conexión a internet
  bool get isDisconnected => !isConnected;

  /// Verifica manualmente el estado de conectividad
  Future<ConnectivityStatus> checkConnectivity() async {
    return await _connectivityService.checkConnectivity();
  }

  /// Ejecuta una acción solo si hay conexión a internet
  Future<T?> executeIfConnected<T>(Future<T> Function() action) async {
    if (isConnected) {
      return await action();
    }
    return null;
  }

  /// Libera los recursos del servicio
  Future<void> dispose() async {
    await _connectivityService.dispose();
    _instance = null;
  }
}

/// Clase de utilidad para acceso rápido al estado de conectividad
class ConnectivityHelper {
  /// Verifica si hay conexión a internet
  static bool get isConnected => 
      GlobalConnectivityService.instance.isConnected;
  
  /// Verifica si NO hay conexión a internet
  static bool get isDisconnected => 
      GlobalConnectivityService.instance.isDisconnected;
  
  /// Estado actual de conectividad
  static ConnectivityStatus get currentStatus => 
      GlobalConnectivityService.instance.currentStatus;
  
  /// Stream de cambios de conectividad
  static Stream<ConnectivityStatus> get connectivityStream => 
      GlobalConnectivityService.instance.connectivityStream;
  
  /// Verifica manualmente la conectividad
  static Future<ConnectivityStatus> checkConnectivity() => 
      GlobalConnectivityService.instance.checkConnectivity();
  
  /// Ejecuta una acción solo si hay conexión
  static Future<T?> executeIfConnected<T>(Future<T> Function() action) => 
      GlobalConnectivityService.instance.executeIfConnected(action);
}