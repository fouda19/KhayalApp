import 'package:flutter/material.dart';
import '\\main.dart'; // Import the MyColors extension

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.gradientStart, colors.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0), // Match the button's border radius
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Make the button background transparent
          shadowColor: Colors.transparent, // Remove button shadow to see the gradient
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}