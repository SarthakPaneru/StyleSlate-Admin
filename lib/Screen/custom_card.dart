import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;
  final VoidCallback onTap; // Add a callback for navigation

  const CustomCard({
    super.key,
    required this.imagePath,
    required this.height,
    required this.width,
    required this.onTap, // Initialize the callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call the callback when the card is tapped
      child: SizedBox(
        height: height,
        width: width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          color: const Color.fromARGB(255, 154, 207, 232),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              height: height * 0.6,
              width: width * 0.6,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
