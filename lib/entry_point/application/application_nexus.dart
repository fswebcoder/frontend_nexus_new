import 'dart:developer';

import 'package:flutter/material.dart';

import '../../core/utils/index.dart';
import '../ui/shared/widgets/connectivity_overlay.dart';
import '../../injector.dart';

class ApplicationNexus extends StatefulWidget {
  const ApplicationNexus({super.key});

  @override
  State<ApplicationNexus> createState() => _ApplicationNexusState();
}

class _ApplicationNexusState extends State<ApplicationNexus>
    with WidgetsBindingObserver {
  late final bool modoOscuro;
  late final GlobalConnectivityService _connectivityService;
  
  @override
  void initState() {
    super.initState();
    // Inicializamos las variables de manera eficiente
    modoOscuro = SingletonSharedPreferencesImp().darkMode ?? false;
    _connectivityService = getIt<GlobalConnectivityService>();
    
    // Registramos el observer para el ciclo de vida
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Limpiamos los recursos
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Verificamos la conectividad cuando la app vuelve al primer plano
      _connectivityService.checkConnectivity();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWrapper(
      connectivityStream: _connectivityService
          .connectivityStream
          .map((status) => status == ConnectivityStatus.connected),
      onRetry: () async {
        await _connectivityService.checkConnectivity();
      },
      customMessage: 'No hay conexión a internet.\n'
                    'Puedes continuar usando la app con funcionalidades limitadas.',
      showConnectionStatus: true,
      child: MaterialApp(
        title: 'Frontend Nexus',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: modoOscuro ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: _buildHomePage(),
      ),
    );
  }

  Widget _buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frontend Nexus'),
        actions: [
          // Indicador de conectividad en el AppBar
          StreamBuilder<ConnectivityStatus>(
            stream: _connectivityService.connectivityStream,
            builder: (context, snapshot) {
              final isConnected = snapshot.data == ConnectivityStatus.connected;
              log('isConnected: $isConnected');
              return Container(
                margin: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    Icon(
                      isConnected ? Icons.wifi_rounded : Icons.wifi_off_rounded,
                      color: isConnected ? Colors.green : Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isConnected ? 'Online' : 'Offline',
                      style: TextStyle(
                        color: isConnected ? Colors.green : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tu aplicación Frontend Nexus',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Sistema de conectividad global implementado ✅',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
