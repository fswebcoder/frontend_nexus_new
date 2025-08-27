import 'package:flutter/material.dart';

/// Widget overlay que se muestra cuando no hay conexión a internet
/// Versión mejorada con animaciones y mejor UX
class ConnectivityOverlay extends StatefulWidget {
  final Widget child;
  final bool isConnected;
  final Future<void> Function()? onRetry;
  final VoidCallback? onDismiss;
  final String? customMessage;

  const ConnectivityOverlay({
    super.key,
    required this.child,
    required this.isConnected,
    this.onRetry,
    this.onDismiss,
    this.customMessage,
  });

  @override
  State<ConnectivityOverlay> createState() => _ConnectivityOverlayState();
}

class _ConnectivityOverlayState extends State<ConnectivityOverlay>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isRetrying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void didUpdateWidget(ConnectivityOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isConnected && oldWidget.isConnected) {
      // Perdió conexión - mostrar overlay
      _animationController.forward();
    } else if (widget.isConnected && !oldWidget.isConnected) {
      // Recuperó conexión - ocultar overlay
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // Usar Alignment no direccional
      children: [
        widget.child,
        if (!widget.isConnected) _buildNoInternetOverlay(context),
      ],
    );
  }

  Widget _buildNoInternetOverlay(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              color: Colors.black.withOpacity(0.7 * _opacityAnimation.value),
              child: Center(
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icono animado
                          TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 1000),
                            tween: Tween(begin: 0, end: 1),
                            builder: (context, value, child) {
                              return Transform.rotate(
                                angle: value * 0.1,
                                child: Icon(
                                  Icons.wifi_off_rounded,
                                  size: 72,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              );
                            },
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Título
                          Text(
                            '¡Ups! Sin internet',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Mensaje
                          Text(
                            widget.customMessage ??
                                'No te preocupes, puedes seguir usando la aplicación '
                                'con funcionalidades limitadas en modo offline.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 32),
                          
                          // Botones de acción
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: widget.onDismiss ?? () {
                                    _animationController.reverse();
                                  },
                                  icon: const Icon(Icons.close),
                                  label: const Text('Continuar'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                              
                              const SizedBox(width: 12),
                              
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _isRetrying ? null : _handleRetry,
                                  icon: _isRetrying
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : const Icon(Icons.refresh),
                                  label: Text(_isRetrying ? 'Verificando...' : 'Reintentar'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Indicador de estado offline
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.orange.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.offline_bolt_rounded,
                                  size: 16,
                                  color: Colors.orange[700],
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Modo offline activo',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.orange[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }

  Future<void> _handleRetry() async {
    if (_isRetrying) return;
    
    setState(() {
      _isRetrying = true;
    });
    
    try {
      // Ejecutar la función de reintento si existe
      if (widget.onRetry != null) {
        await widget.onRetry!();
      }
      // Dar tiempo para mostrar el estado
      await Future.delayed(const Duration(milliseconds: 500));
    } finally {
      if (mounted) {
        setState(() {
          _isRetrying = false;
        });
      }
    }
  }
}

/// Widget que envuelve la aplicación y maneja automáticamente el overlay de conectividad
/// Versión mejorada que funciona con el nuevo ConnectivityOverlay
class ConnectivityWrapper extends StatefulWidget {
  final Widget child;
  final Stream<bool> connectivityStream;
  final Future<void> Function()? onRetry;
  final String? customMessage;
  final bool showConnectionStatus;

  const ConnectivityWrapper({
    super.key,
    required this.child,
    required this.connectivityStream,
    this.onRetry,
    this.customMessage,
    this.showConnectionStatus = true,
  });

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> 
    with TickerProviderStateMixin {
  bool? _isConnected; 
  bool _hasShownOfflineMessage = false;
  bool _isInitialized = false; // Track de si el servicio ya se inicializó
  late AnimationController _bannerController;
  late Animation<double> _bannerAnimation;

  @override
  void initState() {
    super.initState();
    
    _bannerController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _bannerAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _bannerController,
      curve: Curves.easeOut,
    ));
    
    // Obtener el estado inicial y luego suscribirse al stream
    _initializeConnectivityState();
  }

  void _initializeConnectivityState() {
    // Delay inicial para evitar mostrar banners durante la inicialización
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        _isInitialized = true;
      }
    });

    // Suscribirse al stream de conectividad
    widget.connectivityStream.listen((isConnected) {
      _handleConnectivityChange(isConnected);
    });
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  void _handleConnectivityChange(bool isConnected) {
    if (_isConnected == isConnected) return;
    
    setState(() {
      _isConnected = isConnected;
    });
    
    if (!isConnected && !_hasShownOfflineMessage) {
      _hasShownOfflineMessage = true;
    }
    
    // Solo mostrar banner después de que el servicio esté inicializado
    if (widget.showConnectionStatus && _isInitialized) {
      if (!isConnected) {
        _bannerController.forward();
        _scheduleHideBanner();
      } else if (_hasShownOfflineMessage) {
        // Solo mostrar banner de reconexión si se había perdido la conexión antes
        _showConnectionRestoredBanner();
      }
    }
  }

  void _scheduleHideBanner() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _isConnected == false) {
        _bannerController.reverse();
      }
    });
  }

  void _showConnectionRestoredBanner() {
    _bannerController.forward();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _bannerController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // Usar Alignment no direccional
      children: [
        // Contenido principal con overlay de conectividad
        ConnectivityOverlay(
          isConnected: _isConnected ?? true, // Asumir conectado hasta conocer el estado real
          onRetry: widget.onRetry,
          customMessage: widget.customMessage,
          child: widget.child,
        ),
        
        // Banner de estado de conexión (solo mostrar cuando esté inicializado y animación activa)
        if (widget.showConnectionStatus && _isInitialized && _bannerController.value > 0)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
                animation: _bannerAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _bannerAnimation.value * 60),
                    child: SafeArea(
                      bottom: false,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: _isConnected ?? true
                                ? Colors.green 
                                : Colors.red,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _isConnected ?? true
                                    ? Icons.wifi_rounded 
                                    : Icons.wifi_off_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  _isConnected ?? true
                                      ? 'Conexión restaurada'
                                      : 'Sin conexión a internet',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ),
      ],
    );
  }
}