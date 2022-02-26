import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final String label;
  final VoidCallback onPressed;
  const CustomButton({Key? key, required this.label, required this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          color ?? Colors.blue,
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
