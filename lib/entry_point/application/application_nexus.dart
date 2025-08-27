import 'package:flutter/material.dart';
import 'package:frontend_nexus/core/network/connectivity_service.dart' show ConnectivityStatus;
import 'package:frontend_nexus/core/utils/index.dart' show GlobalConnectivityService;
import 'package:frontend_nexus/entry_point/application/config/global_message.dart';
import 'package:frontend_nexus/entry_point/application/router/app_router.dart';
import 'package:frontend_nexus/entry_point/ui/shared/widgets/network/connectivity_overlay.dart' show ConnectivityWrapper;
import 'package:frontend_nexus/injector.dart' show getIt;


import '../../core/utils/singleton_shared_preferences/singleton_shared_preferences_imp.dart' show SingletonSharedPreferencesImp;
import 'config/app_constants.dart';

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
    modoOscuro = SingletonSharedPreferencesImp().darkMode ?? false;
    _connectivityService = getIt<GlobalConnectivityService>();
    
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
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
      customMessage: GlobalMessage.noHayConexion,
      showConnectionStatus: true,
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: AppConstants.appName,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: modoOscuro ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

 
}