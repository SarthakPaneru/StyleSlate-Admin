import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double height;
  final double width;
  final Widget child; // Widget to display inside the card
  final String title; // Title text to display

  const CustomCard({
    super.key,
    required this.height,
    required this.width,
    required this.child, // Initialize the child widget
    required this.title, // Initialize the title text
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        color: const Color.fromARGB(62, 0, 0, 0),
        child: Stack(
          children: [
            const Positioned(
              top: 10,
              right: 10,
              child: ArrowButton(), // Positioned ArrowButton at top-left corner
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Center(child: child), // Center the child widget
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArrowButton extends StatelessWidget {
  const ArrowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, // Adjust size as needed
      height: 40,
      decoration: BoxDecoration(
        color: const Color(
            0xFF4A6D68), // Extracted background color from the image
        borderRadius: BorderRadius.circular(10), // Circular border
      ),
      child: const Center(
        child: Icon(
          Icons.arrow_forward_ios, // Use appropriate arrow icon
          color: Color(0xFF7FFFD4), // Extracted arrow color from the image
          size: 20, // Adjust size as needed
        ),
      ),
    );
  }
}
