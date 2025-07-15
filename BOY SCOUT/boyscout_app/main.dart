import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final List<String> badgeImages = [
    'lib/boyscout_app/assets/images/senior_scout_emblem.png',
    'lib/boyscout_app/assets/images/explorer_badge.png',
    'lib/boyscout_app/assets/images/pathfinder_badge.png',
    'lib/boyscout_app/assets/images/outdoor_scout_badge.png',
    'lib/boyscout_app/assets/images/venturer_badge.png',
    'lib/boyscout_app/assets/images/eagle_scout_badge.png',
  ];

  final List<String> badgeNames = [
    'Senior Scout Emblem',
    'Explorer Badge',
    'Pathfinder Badge',
    'Outdoor Scout Badge',
    'Venturer Badge',
    'Eagle Scout Badge',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'More Info',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(title: Text('BSP Vision & Mission')),
            ListTile(title: Text('Scout Ideals')),
            ListTile(title: Text('BSP Safeguarding Policy')),
            ListTile(title: Text('About Project Hakbayan')),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Scout Profile'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.home), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: const Icon(Icons.calendar_today), onPressed: () {}),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'lib/boyscout_app/assets/images/bg.png',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Welcome Card
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: cardDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              'lib/boyscout_app/assets/images/avatar.png',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi Scout Sargento!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Text("Are you ready to traverse the world of scouting?"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          redButton(label: "Scout Profile"),
                          redButton(label: "Scout Advancement"),
                        ],
                      ),
                    ],
                  ),
                ),

                // Advancement Profile (Image Grid)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: cardDecoration(),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Advancement Profile",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: badgeImages.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Tapped on ${badgeNames[index]}')),
                              );
                            },
                            child: index == 5
                                ? SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(
                                      badgeImages[index],
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                : Image.asset(
                                    badgeImages[index],
                                    fit: BoxFit.contain,
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Scouting Engagement
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: cardDecoration(),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Scouting Engagement",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.spaceAround,
                        children: [
                          badgeLink(context, "Leadership", const LeadershipPage()),
                          badgeLink(context, "Activity/Training", const ActivityPage()),
                          badgeLink(context, "Service Hours", const ServicePage()),
                        ],
                      ),
                    ],
                  ),
                ),

                // Upcoming Events
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: cardDecoration(),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Upcoming Events - July",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 12),
                      EventItem(date: "12", title: "Senior Scouting Orientation Course"),
                      SizedBox(height: 8),
                      EventItem(date: "19", title: "Investiture Ceremony"),
                      SizedBox(height: 8),
                      EventItem(date: "26", title: "Crew Leaders Training Course"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Red Button
  Widget redButton({required String label}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  // Badge Navigation Button
  Widget badgeLink(BuildContext context, String label, Widget targetPage) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => targetPage));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Card Style
  BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(51),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

// Event Widget
class EventItem extends StatelessWidget {
  final String date;
  final String title;

  const EventItem({super.key, required this.date, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, color: Colors.green, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "$date - $title",
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

// Pages
class LeadershipPage extends StatelessWidget {
  const LeadershipPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Leadership")),
        body: const Center(child: Text("Leadership Details")),
      );
}

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Activity / Training")),
        body: const Center(child: Text("Activity Details")),
      );
}

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Service Hours")),
        body: const Center(child: Text("Service Hours Details")),
      );
}
