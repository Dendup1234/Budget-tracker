import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;

  const CustomIconButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Full width button
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: iconColor ?? Colors.white),
        label: Text(
          text,
          style: TextStyle(
            fontFamily: 'HK',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor ?? Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
