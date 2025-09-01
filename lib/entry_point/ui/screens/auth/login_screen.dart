import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_nexus/entry_point/application/config/app_colors.dart';
import 'package:frontend_nexus/entry_point/application/config/global_message.dart';
import 'package:frontend_nexus/entry_point/ui/shared/widgets/forms/button/custom_principal_button.dart';
import 'package:frontend_nexus/entry_point/ui/shared/widgets/index.dart';
import 'package:frontend_nexus/entry_point/ui/shared/widgets/forms/textfield/textfield_strem_widget.dart';
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

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _logoController;
  late AnimationController _backgroundController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _backgroundAnimation;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _initAnimations();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
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

  Future<void> _handleBiometricAuth() async {
    if (kIsWeb) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: const Text('Autenticación biométrica no disponible en web'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
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
            backgroundColor: AppColors.successColor,
          ),
        );
      }
    } catch (e) {
      log('Error en autenticación biométrica: $e');
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Error en autenticación biométrica: $e'),
          backgroundColor: AppColors.errorColor,
        ),
      );
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
                              Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withValues(alpha: 0.1),
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
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.1),
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
                      const isWeb = kIsWeb;
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
          GlobalMessage.derechosReservados,
          style: TextStyle(
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
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
              color:
                  Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .shadow
                      .withValues(alpha: 0.1),
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
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        
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
                  Container(
                    height: isWeb ? 100 : 150,
                    child: Image.asset(
                      isDarkMode ? 'assets/images/blanco.png' : 'assets/images/logo_sv.png',
                      fit: BoxFit.contain,
                    ),
                  ),
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
                label: GlobalMessage.labelEmail,
                hintText: GlobalMessage.hintEmail,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                icon: Icons.email_outlined,
                iconPosition: IconPosition.left,
                tooltip: GlobalMessage.tooltipEmail,
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
                label: GlobalMessage.labelPassword,
                hintText: GlobalMessage.hintPassword,
                controller: _passwordController,
                obscureText: true,
                icon: Icons.lock_outline,
                iconPosition: IconPosition.left,
                tooltip: GlobalMessage.tooltipPassword,
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
      child: CustomPrincipalButton(
        onPressed: () {
          log('onPressed');
        },
        color: AppColors.primary,
        label: 'Iniciar sesión',
        isLoading: false,
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
          style:
              Theme.of(context).textButtonTheme.style?.textStyle?.resolve({}) ??
                  TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
          color: Theme.of(context).colorScheme.onSurface,
        ),
        label: Text(
          'Autenticación Biométrica',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: Theme.of(context).outlinedButtonTheme.style,
      ),
    );
  }

  Row _separatorBiometrics() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Theme.of(context).dividerColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'o',
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6),
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Theme.of(context).dividerColor,
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
                  AppColors.DarkColor1,
                  AppColors.DarkColor2,
                  _backgroundAnimation.value,
                )!,
                Color.lerp(
                  AppColors.primaryColor.shade800,
                  AppColors.primaryColor.shade400,
                  (_backgroundAnimation.value + 0.3) % 1.0,
                )!,
                Color.lerp(
                  AppColors.primaryColor.shade400,
                  AppColors.primaryColor.shade200,
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
