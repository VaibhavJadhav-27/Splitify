import 'package:flutter/material.dart';
import 'package:splitify_app/constants/app_enums.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final double height;
  final double borderRadius;

  const CommonButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.height = 48,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor, textColor, borderColor;

    switch (variant) {
      case ButtonVariant.secondary:
        bgColor = Colors.white;
        textColor = Theme.of(context).primaryColor;
        borderColor = Theme.of(context).primaryColor;
        break;
      case ButtonVariant.text:
        bgColor = Colors.transparent;
        textColor = Theme.of(context).primaryColor;
        borderColor = Colors.transparent;
        break;
      case ButtonVariant.primary:
        bgColor = Theme.of(context).primaryColor;
        textColor = Colors.white;
        borderColor = Colors.transparent;
        break;
    }

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon:
            isLoading
                ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
                : (icon != null
                    ? Icon(icon, color: textColor)
                    : const SizedBox.shrink()),
        label: Text(label, style: TextStyle(fontSize: 16, color: textColor)),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: variant == ButtonVariant.text ? 0 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
        ),
      ),
    );
  }
}
