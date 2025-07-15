import 'package:flutter/material.dart';

void main() {
  runApp(MeritBadgeApp());
}

class MeritBadgeApp extends StatelessWidget {
  const MeritBadgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MeritBadgePage(),
    );
  }
}

class MeritBadgePage extends StatelessWidget {
  const MeritBadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Merit Badge Groups'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Implement back action, if necessary
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/boyscout_app/assets/images/bg.png'), // Set the background image
            fit: BoxFit.cover, // Ensure the image covers the entire screen
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            buildMeritBadgeButton(context, 'Agriculture', 'assets/images/agriculture_icon.png'),
            buildMeritBadgeButton(context, 'Animal Raising', 'assets/images/animal_raising_icon.png'),
            buildMeritBadgeButton(context, 'Arts and Crafts', 'assets/images/arts_and_crafts_icon.png'),
            buildMeritBadgeButton(context, 'Business and Entrepreneurship', 'assets/images/business_and_entrepreneurship_icon.png'),
            buildMeritBadgeButton(context, 'Creative and Performing Arts', 'assets/images/creative_and_performing_arts_icon.png'),
            buildMeritBadgeButton(context, 'Culture and Governance', 'assets/images/culture_and_governance_icon.png'),
            buildMeritBadgeButton(context, 'Science and Technology', 'assets/images/science_and_technology_icon.png'),
            buildMeritBadgeButton(context, 'Trades and Technical Skills', 'assets/images/trades_and_technical_skills_icon.png'),
            buildMeritBadgeButton(context, 'Wellness and Recreation', 'assets/images/wellness_and_recreation_icon.png'),
          ],
        ),
      ),
    );
  }

  // Define the method to create a button for each merit badge
  Widget buildMeritBadgeButton(BuildContext context, String title, String iconPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300], // Button color
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        onPressed: () {
          // Navigate to the next page or handle actions for each badge
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navigating to $title')),
          );
        },
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 40,
              height: 40,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
