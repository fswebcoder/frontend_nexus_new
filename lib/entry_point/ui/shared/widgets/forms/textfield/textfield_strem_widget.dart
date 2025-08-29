import 'package:flutter/material.dart';
import 'package:frontend_nexus/entry_point/application/config/app_colors.dart';
import 'package:super_tooltip/super_tooltip.dart';

enum IconPosition { left, right }

class CustomInput extends StatefulWidget {
  final String label;
  final String? tooltip;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? icon;
  final IconPosition iconPosition;
  final VoidCallback? onIconTap;
  final bool showTooltipOnFocus;
  // Parámetros para integración con Bloc
  final String? initialValue;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const CustomInput({
    super.key,
    required this.label,
    this.tooltip,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.onIconTap,
    this.showTooltipOnFocus = false,
    // Parámetros para Bloc
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  final SuperTooltipController tooltipController = SuperTooltipController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Escuchar cambios de foco
    focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (widget.tooltip != null && widget.showTooltipOnFocus) {
      if (focusNode.hasFocus) {
        tooltipController.showTooltip();
      } else {
        tooltipController.hideTooltip();
      }
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    tooltipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            if (widget.tooltip != null) ...[
              const SizedBox(width: 6),
              SuperTooltip(
                controller: tooltipController,
                backgroundColor: Theme.of(context).colorScheme.surface,
                borderRadius: 8,
                arrowTipDistance: 8,
                popupDirection: TooltipDirection.up,
                showBarrier: false,
                hasShadow: false,
                elevation: 0, 
                content: Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.tooltip!,
                    style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.white70 
                : AppColors.blackColor,
          ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    if (tooltipController.isVisible) {
                      tooltipController.hideTooltip();
                    } else {
                      tooltipController.showTooltip();
                    }
                  },
                  child: Icon(
                    Icons.info_outline,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          focusNode: focusNode,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          validator: widget.validator,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.white70 
                : AppColors.blackColor,
          ),
          initialValue: widget.controller == null ? widget.initialValue : null,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.white38 
                  : AppColors.hintColor,
            ),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark 
                ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.1)
                : Colors.white,
            errorStyle: const TextStyle(
              color: AppColors.errorColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.errorColor,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.errorColor,
                width: 2.0,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.grey.withValues(alpha: 0.3)
                    : Colors.grey.withValues(alpha: 0.2),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.grey.withValues(alpha: 0.3)
                    : Colors.grey.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
            ),
            prefixIcon: widget.icon != null &&
                    widget.iconPosition == IconPosition.left
                ? GestureDetector(
                    onTap: widget.onIconTap,
                    child: Icon(
                      widget.icon, 
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white70 
                          : AppColors.primaryColor,
                      size: 20,
                    ),
                  )
                : null,
            suffixIcon: widget.icon != null &&
                    widget.iconPosition == IconPosition.right
                ? GestureDetector(
                    onTap: widget.onIconTap,
                    child: Icon(
                      widget.icon, 
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white70 
                          : AppColors.primaryColor,
                      size: 20,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
