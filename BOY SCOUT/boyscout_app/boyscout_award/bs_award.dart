import 'package:flutter/material.dart';

void main() {
  runApp(ScoutAwardApp());
}

class ScoutAwardApp extends StatelessWidget {
  // Constructor with a named key parameter, passed to the super constructor
  const ScoutAwardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScoutAwardPage(),
    );
  }
}

class ScoutAwardPage extends StatelessWidget {
  // Constructor with a named key parameter, passed to the super constructor
  const ScoutAwardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scout Advancement'),
        backgroundColor: Colors.purple,
        actions: [
          // Add a back button in the top right
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/boyscout_app/assets/images/bg.png'), // Set the background image
            fit: BoxFit.cover, // Ensure the image covers the entire screen
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildButton(context, 'Advancement Program', const Color.fromARGB(255, 3, 39, 69)),
            buildButton(context, 'Merit Badges & Groups', Colors.red),
            buildButton(context, 'Merit Badge Sash', Colors.yellow),
            buildButton(context, 'COH & BOR Summary', Colors.green),
            buildButton(context, 'Anahaw Award', Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Use backgroundColor instead of primary
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        onPressed: () {
          // Handle button press
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navigating to $text')),
          );
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
