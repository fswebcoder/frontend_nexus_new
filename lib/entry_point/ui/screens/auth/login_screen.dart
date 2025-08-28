import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend_nexus/entry_point/ui/shared/widgets/index.dart';
import 'package:frontend_nexus/entry_point/ui/shared/widgets/forms/textfield_strem_widget.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final LocalAuthentication auth = LocalAuthentication();
  bool showButtonBiometrics = false;

  // Controladores de animación
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _logoController;
  late AnimationController _backgroundController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _backgroundAnimation;

  // Controladores del formulario
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Inicializar animaciones
    _initAnimations();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Solo verificar biometría en plataformas nativas (no web)
      if (!kIsWeb) {
        try {
          final biometricsAvailable = await auth.getAvailableBiometrics();
          log('Biometrics available: $biometricsAvailable');
          if (showButtonBiometrics &&
              biometricsAvailable.contains(BiometricType.strong) &&
              biometricsAvailable.isNotEmpty) {
            //TODO Implementar la autenticación con biometría
          }
        } catch (e) {
          log('Error checking biometrics: $e');
        }
      } else {
        log('Biometrics not available on web platform');
      }

      // Iniciar animaciones después de que se construya el widget
      _startAnimations();
    });
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.fastOutSlowIn,
    ));

    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutBack),
    ));

    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_backgroundController);
  }

  void _startAnimations() {
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 800), () {
      _slideController.forward();
      _fadeController.forward();
    });
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Simular proceso de login
        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          _isLoading = false;
        });

        // Aquí iría tu lógica de autenticación
        _scaffoldMessengerKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text('Login exitoso'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text('Error en login: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleBiometricAuth() async {
    if (kIsWeb) {
      // En web, mostrar mensaje que no está disponible
      _scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('Autenticación biométrica no disponible en web'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Autentícate para acceder a la aplicación',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );

      if (didAuthenticate) {
        _scaffoldMessengerKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text('Autenticación biométrica exitosa'),
            backgroundColor: Colors.green,
          ),
        );
        // Navegar a la siguiente pantalla
      }
    } catch (e) {
      log('Error en autenticación biométrica: $e');
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _logoController.dispose();
    _backgroundController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
          body: Stack(
            children: [
              BuilderAnimated(backgroundAnimation: _backgroundAnimation),
              Positioned(
                top: -100,
                right: -100,
                child: AnimatedBuilder(
                  animation: _backgroundAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _backgroundAnimation.value * 2 * 3.14159,
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Positioned(
                bottom: -150,
                left: -150,
                child: AnimatedBuilder(
                  animation: _backgroundAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: -_backgroundAnimation.value * 2 * 3.14159,
                      child: Container(
                        width: 400,
                        height: 400,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.blue.withValues(alpha: 0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Contenido principal
              SafeArea(
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isWeb = kIsWeb;
                      final screenHeight = constraints.maxHeight;
                      final useScroll =
                          screenHeight < 700; // Solo scroll si es muy pequeña

                      Widget content = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _logoCompany(isWeb, useScroll),
                          _slideTransition(isWeb),
                          _fadeTransition(isWeb),
                        ],
                      );

                      if (useScroll) {
                        return ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                            scrollbars: false,
                          ),
                          child: SingleChildScrollView(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            physics: const BouncingScrollPhysics(),
                            child: content,
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: content,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FadeTransition _fadeTransition(bool isWeb) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: EdgeInsets.only(top: isWeb ? 20 : 40),
        child: Text(
          '© 2025 Quintana SAS',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  SlideTransition _slideTransition(bool isWeb) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: EdgeInsets.all(isWeb ? 24 : 28),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 40,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: _formLogin(),
          ),
        ),
      ),
    );
  }

  AnimatedBuilder _logoCompany(bool isWeb, bool useScroll) {
    return AnimatedBuilder(
      animation: _logoAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoAnimation.value,
          child: Transform.translate(
            offset: Offset(0, (1 - _logoAnimation.value) * 50),
            child: Container(
              margin: EdgeInsets.only(
                bottom: isWeb ? 40 : 60,
                top: useScroll ? 20 : 0,
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/logo_svb.png',
                      height: isWeb ? 100 : 150),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Form _formLogin() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInput(
                label: 'Email',
                hintText: 'tu@empresa.com',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                icon: Icons.email_outlined,
                iconPosition: IconPosition.left,
                tooltip: 'Email',
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu email';
                  }
                  if (!value.contains('@')) {
                    return 'Por favor ingresa un email válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomInput(
                label: 'Contraseña',
                hintText: 'Ingresa tu contraseña',
                controller: _passwordController,
                obscureText: true,
                icon: Icons.lock_outline,
                iconPosition: IconPosition.left,
                tooltip: 'Mínimo 6 caracteres',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
          const SizedBox(height: 24),
          _restoredPassword(),
          const SizedBox(height: 24),
          _buttonLogin(),
          if (showButtonBiometrics) ...[
            const SizedBox(height: 16),
            _separatorBiometrics(),
            const SizedBox(height: 16),
            _biometricsAutenticator(),
          ],
        ],
      ),
    );
  }

  SizedBox _buttonLogin() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
        child: _isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              )
            : const Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Align _restoredPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  SizedBox _biometricsAutenticator() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        onPressed: _handleBiometricAuth,
        icon: Icon(
          Icons.fingerprint,
          color: Colors.white.withValues(alpha: 0.9),
        ),
        label: Text(
          'Autenticación Biométrica',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.3),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Row _separatorBiometrics() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'o',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }
}

class BuilderAnimated extends StatelessWidget {
  const BuilderAnimated({
    super.key,
    required Animation<double> backgroundAnimation,
  }) : _backgroundAnimation = backgroundAnimation;

  final Animation<double> _backgroundAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  const Color(0xFF0F172A),
                  const Color(0xFF1E293B),
                  _backgroundAnimation.value,
                )!,
                Color.lerp(
                  const Color(0xFF1E3A8A),
                  const Color(0xFF3B82F6),
                  (_backgroundAnimation.value + 0.3) % 1.0,
                )!,
                Color.lerp(
                  const Color(0xFF3B82F6),
                  const Color(0xFF60A5FA),
                  (_backgroundAnimation.value + 0.6) % 1.0,
                )!,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}
