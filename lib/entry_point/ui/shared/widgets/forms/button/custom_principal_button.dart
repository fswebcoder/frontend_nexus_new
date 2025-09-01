import 'package:flutter/material.dart';
import 'package:frontend_nexus/entry_point/application/config/app_colors.dart';
import 'package:frontend_nexus/entry_point/ui/shared/widgets/inherited_widget/inherited_widget.dart';
import 'package:frontend_nexus/entry_point/ui/utils/responsive_utils.dart';

class CustomPrincipalButton extends StatelessWidget {
  final Color? color;
  final String? label;
  final bool? isLoading;
  final VoidCallback? onPressed;
  final IconData? icon;

  const CustomPrincipalButton({
    super.key, 
    this.color, 
    this.label, 
    this.isLoading, 
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final darkMode = InheritedCustomWidget.of(context).status;
    final sizeFont = Responsive.text(context);

    return SizedBox(
      height: size.height * 0.08,
      width: size.width * 0.8,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((state) {
            if (state.contains(WidgetState.disabled)) {
              return darkMode
                  ? AppColors.greyColor
                  : AppColors.greyColor.withValues(alpha: 0.5);
            }

            return color ??
                (darkMode
                    ? AppColors.ternaryColor
                    : AppColors.colorOrangeligth.withValues(alpha: 0.8));
          }),
          shape: WidgetStateProperty.resolveWith<OutlinedBorder>((_) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.width * 0.8),
            );
          }),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading ?? false)
              SizedBox(
                width: sizeFont * 0.05,
                height: sizeFont * 0.05,
                child: CircularProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.whiteColor),
                  strokeWidth: sizeFont * 0.01,
                ),
              )
            else
              Text(
                label ?? ' ',
                style: onPressed != null
                    ? Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: sizeFont * 0.038,
                          color: darkMode
                              ? AppColors.whiteColor
                              : Colors.white70,
                          fontWeight: FontWeight.bold,
                        )
                    : Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: sizeFont * 0.038,
                          color: Colors.black.withValues(alpha: 0.4),
                          fontWeight: FontWeight.normal,
                        ),
              ),
            if (!(isLoading ?? false))
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  icon ?? Icons.arrow_forward_ios_outlined,
                  color: darkMode ? AppColors.whiteColor : Colors.white70,
                  size: sizeFont * 0.04,
                ),
              ),
          ],
        ),
      ),
    );
  }
}