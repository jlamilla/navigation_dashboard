import 'package:flutter/material.dart';
import 'package:navigation_design/tokens/colors.dart';

enum ButtonRadius{
  center,
  right,
  left;
}

class CardElevationButton extends StatelessWidget {
  const CardElevationButton({super.key, this.onPressed, required this.title, required this.type,});

  final Function()? onPressed;
  final String title;
  final ButtonRadius type;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: type != ButtonRadius.right ? primaryLightColor: Colors.redAccent.shade200,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: type != ButtonRadius.right ? const Radius.circular(10): Radius.zero,
            bottomRight: type != ButtonRadius.left ? const Radius.circular(10): Radius.zero,
          ),
        ),
      ),
      child: Text(title),
    );
  }
}