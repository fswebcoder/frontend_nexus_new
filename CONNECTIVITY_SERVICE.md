# Servicio Global de Conectividad - VERSIÓN MEJORADA 🚀

Este documento explica cómo usar el servicio global de conectividad implementado en el proyecto, siguiendo la arquitectura hexagonal.

## Características

✅ **Servicio Global**: Accesible desde cualquier parte de la aplicación  
✅ **Arquitectura Hexagonal**: Separación clara entre dominio e infraestructura  
✅ **Overlay Automático Mejorado**: Modal animado moderno cuando no hay internet  
✅ **Modo Offline**: Permite trabajar sin conexión usando base de datos local  
✅ **Stream Reactivo**: Escucha cambios de conectividad en tiempo real  
✅ **Verificación Real Multiplataforma**: Funciona en Web, Desktop y Móvil  
✅ **Indicador Visual**: Banner animado y indicador en AppBar  
✅ **Sin Bloqueos**: Sistema robusto que no se congela al perder conexión  
✅ **Debounce Inteligente**: Evita múltiples verificaciones innecesarias  
✅ **Animaciones Suaves**: Transiciones fluidas y feedback visual mejorado  

## Arquitectura

```
├── core/
│   ├── network/
│   │   ├── connectivity_service.dart          # Puerto (interfaz del dominio)
│   │   └── connectivity_service_impl.dart     # Adaptador (implementación)
│   └── services/
│       └── global_connectivity_service.dart   # Servicio global singleton
└── entry_point/
    └── ui/shared/widgets/
        └── connectivity_overlay.dart          # Widget de overlay
```

## Uso Básico

### 1. Verificar Estado Actual

```dart
import 'package:frontend_nexus/core/utils/index.dart';

// Verificar si hay conexión
if (ConnectivityHelper.isConnected) {
  print('Hay conexión a internet');
}

// Verificar si NO hay conexión
if (ConnectivityHelper.isDisconnected) {
  print('No hay conexión a internet');
}

// Obtener estado detallado
ConnectivityStatus status = ConnectivityHelper.currentStatus;
print('Estado: $status'); // connected, disconnected, unknown
```

### 2. Escuchar Cambios de Conectividad

```dart
// En un StatefulWidget
StreamSubscription<ConnectivityStatus>? _connectivitySubscription;

@override
void initState() {
  super.initState();
  
  _connectivitySubscription = ConnectivityHelper.connectivityStream.listen((status) {
    if (status == ConnectivityStatus.connected) {
      print('Conexión restaurada');
      // Sincronizar datos pendientes
    } else {
      print('Conexión perdida');
      // Cambiar a modo offline
    }
  });
}

@override
void dispose() {
  _connectivitySubscription?.cancel();
  super.dispose();
}
```

### 3. Ejecutar Acciones Solo con Internet

```dart
// Ejecutar una función solo si hay conexión
final result = await ConnectivityHelper.executeIfConnected(() async {
  // Esta función solo se ejecuta si hay internet
  return await apiService.fetchData();
});

if (result != null) {
  print('Datos obtenidos: $result');
} else {
  print('No se pudo obtener datos: sin conexión');
}
```

### 4. Verificación Manual

```dart
// Verificar conectividad manualmente
ConnectivityStatus status = await ConnectivityHelper.checkConnectivity();
print('Estado verificado: $status');
```

## Overlay Automático

El overlay se muestra automáticamente cuando no hay conexión a internet. Está configurado en `ApplicationNexus` y envuelve toda la aplicación.

### Características del Overlay:
- **Diseño Moderno**: Card con bordes redondeados y sombra
- **Mensaje Personalizable**: Informa sobre el modo offline
- **Botón de Reintento**: Permite verificar la conexión nuevamente
- **Botón Continuar**: Permite seguir usando la app en modo offline
- **No Bloquea**: Permite interactuar con la app en segundo plano

## Implementación en Servicios

### Ejemplo: Servicio de Datos con Modo Offline

```dart
class UserService {
  Future<User?> getUser(String id) async {
    if (ConnectivityHelper.isConnected) {
      // Obtener del servidor
      try {
        final user = await apiService.getUser(id);
        // Guardar en cache local
        await localDatabase.saveUser(user);
        return user;
      } catch (e) {
        // Si falla el servidor, usar cache local
        return await localDatabase.getUser(id);
      }
    } else {
      // Modo offline: usar solo base de datos local
      return await localDatabase.getUser(id);
    }
  }
  
  Future<bool> saveUser(User user) async {
    // Siempre guardar localmente primero
    await localDatabase.saveUser(user);
    
    if (ConnectivityHelper.isConnected) {
      // Si hay conexión, sincronizar con servidor
      try {
        await apiService.saveUser(user);
        return true;
      } catch (e) {
        // Marcar para sincronización posterior
        await localDatabase.markForSync(user.id);
        return false;
      }
    } else {
      // Marcar para sincronización cuando haya conexión
      await localDatabase.markForSync(user.id);
      return false;
    }
  }
}
```

### Ejemplo: Sincronización Automática

```dart
class SyncService {
  static StreamSubscription<ConnectivityStatus>? _subscription;
  
  static void startAutoSync() {
    _subscription = ConnectivityHelper.connectivityStream.listen((status) {
      if (status == ConnectivityStatus.connected) {
        _syncPendingData();
      }
    });
  }
  
  static Future<void> _syncPendingData() async {
    final pendingItems = await localDatabase.getPendingSyncItems();
    
    for (final item in pendingItems) {
      try {
        await apiService.syncItem(item);
        await localDatabase.markAsSynced(item.id);
      } catch (e) {
        print('Error sincronizando ${item.id}: $e');
        break; // Detener si hay error
      }
    }
  }
  
  static void stopAutoSync() {
    _subscription?.cancel();
  }
}
```

## Configuración

El servicio se inicializa automáticamente en `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await configureInjection('main');
  
  // Inicializar servicio de conectividad
  final connectivityService = getIt<GlobalConnectivityService>();
  await GlobalConnectivityService.initialize(connectivityService);
  
  runApp(const ApplicationNexus());
}
```

## Dependencias

El servicio utiliza las siguientes dependencias:

- `connectivity_plus: ^6.1.5` - Para detectar cambios de conectividad
- `injectable: ^2.5.1` - Para inyección de dependencias
- `get_it: ^8.2.0` - Para el contenedor de dependencias

## Buenas Prácticas

1. **Siempre verificar conectividad** antes de operaciones de red
2. **Guardar datos localmente** como respaldo
3. **Marcar datos para sincronización** cuando no hay conexión
4. **Manejar errores graciosamente** y mostrar mensajes apropiados
5. **Usar el helper** `ConnectivityHelper` para acceso rápido
6. **Escuchar cambios** para reaccionar automáticamente
7. **Liberar recursos** cancelando subscripciones en dispose

## Ejemplo Completo

Ver `lib/example_usage.dart` para un ejemplo completo de implementación.