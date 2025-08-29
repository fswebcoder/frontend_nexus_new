import 'package:flutter/material.dart';
import 'package:frontend_nexus/entry_point/application/config/global_message.dart';
import 'package:frontend_nexus/entry_point/ui/shared/widgets/dialog/custom_dialog.dart';


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
      alignment: Alignment.center, 
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
              color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.3 * _opacityAnimation.value),
              child: Center(
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: CustomDialog(
                    icon: Icons.wifi_off_rounded,
                    title: 'Sin conexión a internet',
                    content: const Text(GlobalMessage.mensajeNoHayConexion),
                    cancelText: 'Reintentar',
                    confirmText: 'Cerrar',
                    onCancel: _handleRetry,
                    onConfirm: widget.onDismiss,
                  )
                  ),
                ),
              ),
            
          );
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
      if (widget.onRetry != null) {
        await widget.onRetry!();
      }
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
  bool _isInitialized = false; 
  late AnimationController _bannerController;

  @override
  void initState() {
    super.initState();
    
    _bannerController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _initializeConnectivityState();
  }

  void _initializeConnectivityState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        _isInitialized = true;
      }
    });

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
    
    if (widget.showConnectionStatus && _isInitialized) {
      if (!isConnected) {
        _bannerController.forward();
        _scheduleHideBanner();
      } else if (_hasShownOfflineMessage) {
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
      alignment: Alignment.center, 
      children: [
        ConnectivityOverlay(
          isConnected: _isConnected ?? true, 
          onRetry: widget.onRetry,
          customMessage: widget.customMessage,
          child: widget.child,
        ),
        

      ],
    );
  }
}