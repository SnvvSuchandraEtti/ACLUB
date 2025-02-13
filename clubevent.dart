import 'package:aclub/views/club/cluba.dart';
import 'package:aclub/views/club/events.dart';
import 'package:aclub/views/events/event_screen.dart';
import 'package:aclub/views/events/event_screena.dart';
import 'package:aclub/views/events/event_screenb.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class ClubsEventScreen extends StatefulWidget {
  const ClubsEventScreen({super.key});

  @override
  State<ClubsEventScreen> createState() => _ClubsEventScreenState();
}

class _ClubsEventScreenState extends State<ClubsEventScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([

              _buildSectionHeader('🔴Live Events', onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Eventscr()),
                );
              }),
              _buildListeningSection(),
              const SizedBox(height: 20),
              _buildSectionHeader('Events Ongoing', onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Eventscra()),
                );
              }),
              _buildKnowledgeSection(),
              const SizedBox(height: 18),
              _buildSectionHeader('Upcoming Events', onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Eventscrb()),
                );
              }),
              _buildledgeSection(),
              const SizedBox(height: 18),
              _buildSectionHeader('Past Events', onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventScreen()),
                );
              }),
              _buildPastSection(),
            ]),
          ),
        ],
      ),
    );
  }
}




  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: const Text('See All'),
            ),
        ],
      ),
    );
  }










  Widget _buildEventGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => _buildEventCard(context, index),
    );
  }

  Widget _buildEventCard(BuildContext context, int index) {
    final List<Map<String, dynamic>> events = [
      {
        'title': 'Leadership Workshop',
        'date': 'March 25',
        'image': 'assets/ob/ob1.jpg',
        'club': 'LEO Club'
      },
      {
        'title': 'Music Festival',
        'date': 'April 2',
        'image': 'assets/ob/ob2.jpg',
        'club': 'SAC'
      },
      {
        'title': 'Coding Challenge',
        'date': 'April 5',
        'image': 'assets/ob/ob3.jpg',
        'club': 'IEDC'
      },
      {
        'title': 'Cultural Night',
        'date': 'April 8',
        'image': 'assets/ob/ob1.jpg',
        'club': 'NSS'
      },
    ];

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClubsScreena(),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(events[index]['image']),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
              ],
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                events[index]['date'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                events[index]['title'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Iconsax.clock, color: Colors.white, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    '6:00 PM',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: 15),
      itemBuilder: (context, index) => _buildNewsCard(index),
    );
  }

  Widget _buildNewsCard(int index) {
    final List<Map<String, dynamic>> newsItems = [
      {
        'title': 'New Club Registration Open',
        'excerpt': 'Register your new student organization before April 30...',
        'date': '2h ago'
      },
      {
        'title': 'Annual Fest Schedule Released',
        'excerpt': 'Check out the complete schedule for this year\'s college fest...',
        'date': '5h ago'
      },
      {
        'title': 'Leadership Workshop Results',
        'excerpt': 'View the results of the inter-college leadership workshop...',
        'date': '1d ago'
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.info_circle, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsItems[index]['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      newsItems[index]['date'],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            newsItems[index]['excerpt'],
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListeningSection() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildListeningCard('assets/ob/ob3.jpg', 'LEO EVENT 8/12'),
          _buildListeningCard('assets/ob/ob2.jpg', 'ROT EVENT 15/20'),
          _buildListeningCard('assets/ob/ob1.jpg', 'NSS EVENT 5/15'),
          _buildListeningCard('assets/ob/ob4.jpg', 'LEO EVENT /12'),
          _buildListeningCard('assets/ob/ob2.jpg', 'ROT EVENT 15/20'),
          _buildListeningCard('assets/ob/ob1.jpg', 'NSS EVENT 5/15'),

        ],
      ),
    );
  }

  Widget _buildListeningCard(String imagePath, String episode) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.black54,
          child: Text(
            episode,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildKnowledgeSection() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildListeningCard('assets/ob/ob3.jpg', 'LEO EVENT 8/12'),
          _buildListeningCard('assets/ob/ob2.jpg', 'ROT EVENT 15/20'),
          _buildListeningCard('assets/ob/ob1.jpg', 'NSS EVENT 5/15'),
          _buildListeningCard('assets/ob/ob4.jpg', 'LEO EVENT /12'),
          _buildListeningCard('assets/ob/ob2.jpg', 'ROT EVENT 15/20'),
          _buildListeningCard('assets/ob/ob1.jpg', 'NSS EVENT 5/15'),],
// Improved code for the selected portion
// Since t]here is no selected portion, I will provide an improved version of the entire code  ),
      ),
    );
  }

  Widget _buildledgeSection() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildListeningCard('assets/ob/ob2.jpg', 'LEO EVENT 8/42'),
          _buildListeningCard('assets/ob/ob1.jpg', 'ROT EVENT 15/30'),
          _buildListeningCard('assets/ob/ob3.jpg', 'NSS EVENT 5/11'),
          _buildListeningCard('assets/ob/ob4.jpg', 'LEO EVENT 3/12'),
          _buildListeningCard('assets/ob/ob1.jpg', 'ROT EVENT 5/10'),
          _buildListeningCard('assets/ob/ob3.jpg', 'NSS EVENT 5/13'),],
// Improved code for the selected portion
// Since there is no selected portion, I will provide an improved version of the entire code  ),
      ),
    );
  }

  Widget _buildPastSection() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
_buildListeningCard('assets/ob/ob4.jpg', 'LEO EVENT 3/12'),
          _buildListeningCard('assets/ob/ob2.jpg', 'LEO EVENT 8/42'),
          _buildListeningCard('assets/ob/ob1.jpg', 'ROT EVENT 15/30'),
          _buildListeningCard('assets/ob/ob3.jpg', 'NSS EVENT 5/11'),
          _buildListeningCard('assets/ob/ob1.jpg', 'ROT EVENT 5/10'),
          _buildListeningCard('assets/ob/ob3.jpg', 'NSS EVENT 5/13'),],
// Improved code for the selected portion
// Since there is no selected portion, I will provide an improved version of the entire code  ),
      ),
    );
  }
