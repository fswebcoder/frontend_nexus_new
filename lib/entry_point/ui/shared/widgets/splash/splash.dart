import 'package:flutter/material.dart';
import 'package:frontend_nexus/entry_point/application/config/app_colors.dart';
import 'package:frontend_nexus/entry_point/application/config/app_constants.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _orbitsController;
  late AnimationController _wavesController;
  late AnimationController _textController;
  late AnimationController _hologramController;
  late AnimationController _particlesMagicController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoLevitationAnimation;

  late Animation<double> _orbit1RotationAnimation;
  late Animation<double> _orbit2RotationAnimation;
  late Animation<double> _orbit3RotationAnimation;
  late Animation<double> _toolsScaleAnimation;
  late Animation<double> _connectionsAnimation;

  late Animation<double> _waveExpansionAnimation;
  late Animation<double> _waveOpacityAnimation;
  late Animation<double> _magicParticlesAnimation;
  late Animation<double> _energyPulseAnimation;

  late Animation<double> _textFadeAnimation;
  late Animation<double> _subtitleWaveAnimation;

  late Animation<double> _hologramShiftAnimation;
  late Animation<double> _hologramIntensityAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    _logoController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _orbitsController = AnimationController(duration: const Duration(milliseconds: 6000), vsync: this);
    _wavesController = AnimationController(duration: const Duration(milliseconds: 3000), vsync: this);
    _textController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    _hologramController = AnimationController(duration: const Duration(milliseconds: 4000), vsync: this);
    _particlesMagicController = AnimationController(duration: const Duration(milliseconds: 5000), vsync: this);

    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );

    _logoLevitationAnimation = Tween<double>(begin: 0.0, end: 6.0).animate(
      CurvedAnimation(parent: _hologramController, curve: Curves.easeInOutSine),
    );

    _orbit1RotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _orbitsController, curve: Curves.linear),
    );

    _orbit2RotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _orbitsController, curve: Curves.linear),
    );

    _orbit3RotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _orbitsController, curve: Curves.linear),
    );

    _toolsScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _orbitsController, curve: const Interval(0.0, 0.3, curve: Curves.elasticOut)),
    );

    _connectionsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _orbitsController, curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );

    _waveExpansionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _wavesController, curve: Curves.easeOutQuart),
    );

    _waveOpacityAnimation = Tween<double>(begin: 0.6, end: 0.0).animate(
      CurvedAnimation(parent: _wavesController, curve: Curves.easeOut),
    );

    _magicParticlesAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _particlesMagicController, curve: Curves.linear),
    );

    _energyPulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _hologramController, curve: Curves.easeInOutSine),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    _subtitleWaveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack)),
    );

    _hologramShiftAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hologramController, curve: Curves.linear),
    );

    _hologramIntensityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hologramController, curve: Curves.easeInOutSine),
    );
  }

  void _startAnimationSequence() async {
    try {
      if (mounted) {
        _particlesMagicController.repeat();
        _hologramController.repeat(reverse: true);
        _wavesController.repeat();
      }

      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        _logoController.forward();
        _orbitsController.repeat();
      }

      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) _textController.forward();

      await Future.delayed(const Duration(milliseconds: 2500));
      if (mounted) _navigateToLogin();
    } catch (e) {
      if (mounted) _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    context.go('/login');
  }

  @override
  void dispose() {
    _logoController.dispose();
    _orbitsController.dispose();
    _wavesController.dispose();
    _textController.dispose();
    _hologramController.dispose();
    _particlesMagicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: _buildCleanBackground(),
        child: SafeArea(
          child: Stack(
            children: [
              _buildEnergyWaves(),
              _buildMagicParticles(),
              _buildToolsOrbits(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    _buildCleanLogo(),
                    const SizedBox(height: 60),
                    _buildCleanText(),
                    const Spacer(flex: 2),
                    _buildCleanLoadingIndicator(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildCleanBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.primaryColor.shade800,
          AppColors.primaryColor.shade700,
          AppColors.primaryColor.shade600,
          AppColors.primaryColor.shade500,
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
      ),
    );
  }

  Widget _buildCleanLogo() {
    return AnimatedBuilder(
      animation: Listenable.merge([_logoController, _hologramController]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            -(_logoLevitationAnimation.value * math.sin(_hologramShiftAnimation.value * math.pi * 2)).clamp(-10.0, 10.0),
          ),
          child: Transform.scale(
            scale: (_logoScaleAnimation.value * _energyPulseAnimation.value).clamp(0.0, 2.0),
            child: Opacity(
              opacity: _logoFadeAnimation.value.clamp(0.0, 1.0),
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.shade900.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: AppColors.secondaryColor.withValues(alpha: 0.2),
                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    decoration: BoxDecoration(
                      // Fondo más limpio
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withValues(alpha: 0.15),
                          Colors.white.withValues(alpha: 0.08),
                          Colors.white.withValues(alpha: 0.05),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo_svb.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback si no encuentra la imagen
                          return Icon(
                            Icons.apps,
                            size: 80,
                            color: Colors.white.withValues(alpha: 0.9),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCleanText() {
    return AnimatedBuilder(
      animation: Listenable.merge([_textController, _hologramController]),
      builder: (context, child) {
        return Opacity(
          opacity: _textFadeAnimation.value.clamp(0.0, 1.0),
          child: Column(
            children: [
              Text(
                AppConstants.empresa,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Subtítulo con mejor contraste
              AnimatedBuilder(
                animation: _subtitleWaveAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _subtitleWaveAnimation.value.clamp(0.0, 1.0),
                    child: Text(
                      AppConstants.suiteDescription,
                        style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryColor.shade200,
                        letterSpacing: 3.0,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCleanLoadingIndicator() {
    return AnimatedBuilder(
      animation: _hologramController,
      builder: (context, child) {
        return Column(
          children: [
            // Indicador más elegante
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondaryColor.shade300),
                backgroundColor: Colors.white.withValues(alpha: 0.2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Inicializando suite...',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.7),
                letterSpacing: 0.8,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEnergyWaves() {
    return AnimatedBuilder(
      animation: _wavesController,
      builder: (context, child) {
        return Positioned.fill(
          child: CustomPaint(
            painter: EnergyWavesPainter(
              expansion: _waveExpansionAnimation.value,
              opacity: _waveOpacityAnimation.value,
              pulse: _energyPulseAnimation.value,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMagicParticles() {
    return AnimatedBuilder(
      animation: _particlesMagicController,
      builder: (context, child) {
        return Positioned.fill(
          child: CustomPaint(
            painter: MagicParticlesPainter(
              progress: _magicParticlesAnimation.value,
              intensity: _hologramIntensityAnimation.value,
            ),
          ),
        );
      },
    );
  }

  Widget _buildToolsOrbits() {
    return AnimatedBuilder(
      animation: Listenable.merge([_orbitsController, _hologramController]),
      builder: (context, child) {
        return Positioned.fill(
          child: CustomPaint(
            painter: ToolsOrbitsPainter(
              orbit1Rotation: _orbit1RotationAnimation.value,
              orbit2Rotation: _orbit2RotationAnimation.value,
              orbit3Rotation: _orbit3RotationAnimation.value,
              toolsScale: _toolsScaleAnimation.value,
              connectionsOpacity: _connectionsAnimation.value,
              hologramShift: _hologramShiftAnimation.value,
            ),
          ),
        );
      },
    );
  }
}

// Painters simplificados y optimizados
class EnergyWavesPainter extends CustomPainter {
  final double expansion;
  final double opacity;
  final double pulse;

  EnergyWavesPainter({required this.expansion, required this.opacity, required this.pulse});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = 0; i < 3; i++) {
      final waveRadius = (size.width * 0.2 + i * 30) * expansion.clamp(0.0, 1.0) * pulse.clamp(0.5, 1.5);
      final waveOpacity = (opacity * (1.0 - i * 0.3)).clamp(0.0, 1.0);

      paint.color = AppColors.secondaryColor.withValues(alpha: (waveOpacity * 0.3).clamp(0.0, 1.0));
      canvas.drawCircle(center, waveRadius, paint);
    }
  }

  @override
  bool shouldRepaint(EnergyWavesPainter oldDelegate) {
    return oldDelegate.expansion != expansion || 
           oldDelegate.opacity != opacity || 
           oldDelegate.pulse != pulse;
  }
}

class MagicParticlesPainter extends CustomPainter {
  final double progress;
  final double intensity;

  MagicParticlesPainter({required this.progress, required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      final angle = (i * 0.618 + progress.clamp(0.0, 1.0) * 0.3) * math.pi * 2;
      final distance = (size.width * 0.15) + (size.width * 0.3) * ((i * 0.382 + progress.clamp(0.0, 1.0) * 0.2) % 1.0);

      final x = size.width / 2 + math.cos(angle) * distance;
      final y = size.height / 2 + math.sin(angle) * distance * 0.8;

      final particleIntensity = (math.sin(progress.clamp(0.0, 1.0) * math.pi * 2 + i) * 0.5 + 0.5).clamp(0.0, 1.0);
      final particleOpacity = (particleIntensity * intensity.clamp(0.0, 1.0) * 0.4).clamp(0.0, 1.0);

      paint.color = AppColors.secondaryColor.withValues(alpha: particleOpacity);
      canvas.drawCircle(Offset(x, y), 2 * particleIntensity, paint);
    }
  }

  @override
  bool shouldRepaint(MagicParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.intensity != intensity;
  }
}

class ToolsOrbitsPainter extends CustomPainter {
  final double orbit1Rotation;
  final double orbit2Rotation;
  final double orbit3Rotation;
  final double toolsScale;
  final double connectionsOpacity;
  final double hologramShift;

  ToolsOrbitsPainter({
    required this.orbit1Rotation,
    required this.orbit2Rotation,
    required this.orbit3Rotation,
    required this.toolsScale,
    required this.connectionsOpacity,
    required this.hologramShift,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.fill;

    // Órbitas más sutiles
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = Colors.white.withValues(alpha: (connectionsOpacity * 0.15).clamp(0.0, 1.0));

    canvas.drawCircle(center, size.width * 0.2, paint);
    canvas.drawCircle(center, size.width * 0.28, paint);
    canvas.drawCircle(center, size.width * 0.36, paint);

    // Puntos en las órbitas más pequeños y elegantes
    final orbits = [
      {'radius': size.width * 0.2, 'rotation': orbit1Rotation, 'count': 4},
      {'radius': size.width * 0.28, 'rotation': -orbit2Rotation, 'count': 6},
      {'radius': size.width * 0.36, 'rotation': orbit3Rotation, 'count': 8},
    ];

    paint.style = PaintingStyle.fill;

    for (var orbit in orbits) {
      final radius = orbit['radius'] as double;
      final rotation = orbit['rotation'] as double;
      final count = orbit['count'] as int;

      for (int i = 0; i < count; i++) {
        final angle = rotation + (i * 2 * math.pi / count);
        final x = center.dx + math.cos(angle) * radius;
        final y = center.dy + math.sin(angle) * radius;

        paint.color = AppColors.secondaryColor.withValues(alpha: (toolsScale.clamp(0.0, 1.0) * 0.6).clamp(0.0, 1.0));
        canvas.drawCircle(Offset(x, y), 3 * toolsScale.clamp(0.0, 1.0), paint);
      }
    }
  }

  @override
  bool shouldRepaint(ToolsOrbitsPainter oldDelegate) {
    return oldDelegate.orbit1Rotation != orbit1Rotation ||
           oldDelegate.orbit2Rotation != orbit2Rotation ||
           oldDelegate.orbit3Rotation != orbit3Rotation ||
           oldDelegate.toolsScale != toolsScale ||
           oldDelegate.connectionsOpacity != connectionsOpacity;
  }
}