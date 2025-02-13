import 'package:flutter/material.dart';

// group Screen with ListView
class ClubsScreen extends StatefulWidget {
  const ClubsScreen({super.key});

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
  
  final List<Map<String, dynamic>> eventsItems = [
    {
      'title': 'Rama Deshmukh',
      'speaker': 'Rama Shankar',
      'time': '2nd year',
      'duration': 'AIML',
      'profile': 'assets/ROT.png',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'Ram',
    },
    {
      'title': 'Shivaji Deshmukh',
      'speaker': 'Shiva Shankar',
      'time': '3rd year',
      'duration': 'ECE',
      'profile': 'assets/ROT.png',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'SHIVA',
    },
    {
      'title': 'Babji Deshmukh',
      'speaker': 'Baba Shankar',
      'time': '3rd year',
      'duration': 'CSE',
      'profile': 'assets/ROT.png',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'BABA',
    },
    {
      'title': 'Shivaji Babu',
      'speaker': 'Shiva Shyam',
      'time': '2nd year',
      'duration': 'EEE',
      'profile': 'assets/ROT.png',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'SHIVARAM',
    },
    {
      'title': 'Babji Deshmukh',
      'speaker': 'Baba Shankar',
      'time': '3rd year',
      'duration': 'CSE',
      'profile': 'assets/ROT.png',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'BABA',
    },
    {
      'title': 'Shivaji Babu',
      'speaker': 'Shiva Shyam',
      'time': '2nd year',
      'duration': 'EEE',
      'profile': 'assets/ROT.png',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'SHIVARAM',
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
      'organization': 'SHIVARAM',
    },

  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Widget buildtabCard(BuildContext context, Map<String, dynamic> item) {
    // Use MediaQuery for responsive card margins and text size
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = screenWidth * 0.02;
    final titleFontSize = screenWidth * 0.045;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(data: item),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: cardMargin, horizontal: cardMargin * 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            vertical: cardMargin,
            horizontal: cardMargin * 2,
          ),
          leading: CircleAvatar(
            radius: screenWidth * 0.07,
            backgroundImage: AssetImage(item['profile']),
          ),
          title: Text(
            item['title'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize),
          ),
          subtitle: Text('${item['duration']} | ${item['time']}'),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange, size: screenWidth * 0.05),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve MediaQuery data
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
              text: 'Members',
              icon: Icon(Icons.group),
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
          // Members tab
          ListView.builder(
            itemCount: groupItems.length,
            itemBuilder: (context, index) {
              return buildtabCard(context, groupItems[index]);
            },
          ),
          // Events tab
          ListView.builder(
            itemCount: eventsItems.length,
            itemBuilder: (context, index) {
              return buildtabCard(context, eventsItems[index]);
            },
          ),
          // About tab
          ListView.builder(
            itemCount: aboutItems.length,
            itemBuilder: (context, index) {
              return buildtabCard(context, aboutItems[index]);
            },
          ),
        ],
      ),
    );
  }
}

// Detail Screen
class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailScreen({super.key, required this.data});

  Widget buildSocialIcons(BuildContext context, List<String> social) {
    // Use MediaQuery to adjust icon size based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.08; // 8% of screen width

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
    // Use MediaQuery to set responsive paddings and avatar radius
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
              // Share functionality
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
