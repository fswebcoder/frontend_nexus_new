import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend_nexus/entry_point/ui/shared/widgets/index.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final LocalAuthentication auth = LocalAuthentication();
  bool _authenticated = false;
  bool showButtonBiometrics = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final biometricsAvailable = await auth.getAvailableBiometrics();
      log('Biometrics available: $biometricsAvailable');
      if (showButtonBiometrics &&
          biometricsAvailable.contains(BiometricType.strong) &&
          biometricsAvailable.isNotEmpty) {
        //TODO Implementar la autenticación con biometría
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScopeCustomWidget(
      callBack: () {
        log('WillPopScopeCustomWidget');
      },
      child: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          key: _scaffoldKey,
          body: const Stack(
            children: [
                Text('Login'),
                Text('Login'),
            ],
          ),
        ),
      ),
    );
  }
}
