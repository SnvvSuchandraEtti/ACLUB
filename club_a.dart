import 'package:aclub/views/events/clubevent.dart';
import 'package:flutter/material.dart';

/// Main Screen with TabBar and TabBarView
class ClubsScreen_a extends StatefulWidget {
  const ClubsScreen_a({super.key});

  @override
  State<ClubsScreen_a> createState() => _ClubsScreen_aState();
}

class _ClubsScreen_aState extends State<ClubsScreen_a>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Data for the bio (Club info), events, and about sections
  final List<Map<String, dynamic>> groupItems = [
    {
      'title': 'Shivaji Deshmukh',
      'speaker': 'Shiva Shankar',
      'time': '3rd year',
      'duration': 'ECE',
      'profile': 'assets/NSS.png',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'SHIVA',
    },
  ];


  final List<Map<String, dynamic>> aboutItems = [
    {
      'title': 'Shivaji Babu',
      'speaker': 'Shiva Shyam',
      'time': '2nd year',
      'duration': 'EEE',
      'profile': 'assets/RED.jpg',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'LEO',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Three tabs: Events, Bio, About
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Build a card for an event (non-clickable)
  Widget buildEventCard(BuildContext context, Map<String, dynamic> item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = screenWidth * 0.02;

    return Card(
      margin:
          EdgeInsets.symmetric(vertical: cardMargin, horizontal: cardMargin * 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image at the top
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage(item['profile']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(cardMargin * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Coordinator: ${item['speaker']}'),
                const SizedBox(height: 4),
                Text('Time: ${item['time']} | Category: ${item['duration']}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build a card for the club's bio (clickable)
  Widget buildBioCard(BuildContext context, Map<String, dynamic> item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = screenWidth * 0.02;

    return GestureDetector(
      onTap: () {
        // Navigate to a detailed bio page when card is clicked
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(data: item),
          ),
        );
      },
      child: Card(
        margin:
            EdgeInsets.symmetric(vertical: cardMargin, horizontal: cardMargin * 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              vertical: cardMargin, horizontal: cardMargin * 2),
          leading: CircleAvatar(
            radius: screenWidth * 0.07,
            backgroundImage: AssetImage(item['profile']),
          ),
          title: Text(
            item['organization'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.045,
            ),
          ),
          subtitle: Text(
            'Club Leader: ${item['speaker']}\nYear: ${item['time']} | Branch: ${item['duration']}',
          ),
        ),
      ),
    );
  }

  /// Build a card for the about section (non-clickable)
  Widget buildAboutCard(BuildContext context, Map<String, dynamic> item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = screenWidth * 0.02;

    return Card(
      margin:
          EdgeInsets.symmetric(vertical: cardMargin, horizontal: cardMargin * 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(cardMargin * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['organization'],
              style: TextStyle(
                  fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'About this club:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // Detailed description can be added here
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Quisque ac eros nec sapien dignissim interdum. '
              'Suspendisse potenti. ',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LEO CLUB',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Roboto',
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        shadowColor: Colors.black45,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Add notification action here
            },
            tooltip: 'Notifications',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 4.0,
          labelStyle: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.normal,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(
              text: 'Events',
              icon: Icon(Icons.calendar_month_outlined),
            ),
            Tab(
              text: 'Bio',
              icon: Icon(Icons.person),
            ),
            Tab(
              text: 'About',
              icon: Icon(Icons.info),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
            const ClubsEventScreen(), // Events tab now shows ClubsEventScreen

          // Tab 1: Events (non-clickable UI)

          // Tab 2: Club Bio (clickable card)
          ListView.builder(
            itemCount: groupItems.length,
            itemBuilder: (context, index) {
              return buildBioCard(context, groupItems[index]);
            },
          ),
          // Tab 3: About section (non-clickable UI)
          ListView.builder(
            itemCount: aboutItems.length,
            itemBuilder: (context, index) {
              return buildAboutCard(context, aboutItems[index]);
            },
          ),
        ],
      ),
    );
  }
}

/// Detail Screen (Common for clickable cards)
class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  const DetailScreen({super.key, required this.data});

  Widget buildSocialIcons(BuildContext context, List<String> social) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.08;
    final Map<String, IconData> icons = {
      'facebook': Icons.facebook,
      'instagram': Icons.airplanemode_on_outlined,
      'linkedin': Icons.camera_alt,
      'web': Icons.language,
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: social
          .map(
            (platform) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                icons[platform],
                size: iconSize,
                color: Colors.grey[700],
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth * 0.2;
    final fontSize = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          data['speaker'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality can be added here.
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundImage: AssetImage(data['profile']),
            ),
            SizedBox(height: screenWidth * 0.05),
            Text(
              data['organization'],
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenWidth * 0.1),
            buildSocialIcons(context, data['social']),
          ],
        ),
      ),
    );
  }
}
