import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 190, 196, 187),
              Color.fromARGB(255, 214, 220, 216),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight), // LinearGradient
      ), // BoxDecoration
      child: child,
    ); // Container
  }
}
