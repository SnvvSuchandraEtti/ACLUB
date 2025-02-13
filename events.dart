import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'ACLUB',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView( // Wrap body with SingleChildScrollView for scrolling
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
          child: Column( // Arrange cards in a column
            children: [
              _buildCard(
                'assets/ACLUB_1.gif',
                'Basic dummy data',
                'Welcome to ACLUB, your one-stop destination for all things technical. Let’s begin your journey!',
                screenHeight, // Pass screenHeight to adjust card height dynamically
              ),
              SizedBox(height: screenWidth * 0.04), // Add spacing between cards
              _buildCard(
                'assets/ACLUB_1.gif', // Replace with actual image path
                'Card Title 2',
                'Card Description 2',
                screenHeight,
              ),
              SizedBox(height: screenWidth * 0.04),
              _buildCard(
                'assets/ACLUB_1.gif', // Replace with actual image path
                'Card Title 3',
                'Card Description 3',
                screenHeight,
              ),
              SizedBox(height: screenWidth * 0.04),
              _buildCard(
                'assets/ACLUB_1.gif', // Replace with actual image path
                'Card Title 4',
                'Card Description 4',
                screenHeight,
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget _buildCard(String imagePath, String title, String description, double screenHeight) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.fill,
              height: screenHeight * 0.2, // Set height based on screen size
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Add action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Learn More'),
            ),
          ),
        ],
      ),
    );
  }
}