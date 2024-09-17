import 'package:flutter/material.dart';

class ParallaxEffect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 5, // Width for 5 images
          child: Stack(
            children: [
              ParallaxImage('assets/image1.jpg', 1.0),
              ParallaxImage('assets/image2.jpg', 0.8),
              ParallaxImage('assets/image3.jpg', 0.6),
              ParallaxImage('assets/image4.jpg', 0.4),
              ParallaxImage('assets/image5.jpg', 0.2),
            ],
          ),
        ),
      ),
    );
  }
}

class ParallaxImage extends StatelessWidget {
  final String imagePath;
  final double speedFactor;

  const ParallaxImage(this.imagePath, this.speedFactor);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              // Check if the notification is about the correct axis
              if (scrollNotification.metrics.axis == Axis.horizontal) {
                final scrollOffset = scrollNotification.metrics.pixels;
                // Calculate the offset for this layer
                final double offset = scrollOffset * speedFactor;

                // Apply the parallax effect
                Transform.translate(
                  offset: Offset(-offset, 0), // Horizontal parallax
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: constraints.maxWidth,
                    alignment: Alignment.topCenter,
                  ),
                );
              }
              return true;
            },
            child: SizedBox.shrink(), // Placeholder widget
          );
        },
      ),
    );
  }
}
