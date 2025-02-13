
import 'package:flutter/material.dart';

class Eventscra extends StatelessWidget {
  const Eventscra({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Event Categories',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade700, Colors.blue.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
        child: GridView.count(
          crossAxisCount: screenWidth > 600 ? 3 : 2, // Adjust columns for tablets
          mainAxisSpacing: screenHeight * 0.02, // Responsive spacing
          crossAxisSpacing: screenWidth * 0.03,
          childAspectRatio: screenWidth > 600 ? 0.8 : 0.9, // Adjust aspect ratio for tablets
          children: [
            _CategoryCard(
              image: 'assets/SAC.jpg',
              label: 'Tech Events',
              onTap: () => _navigateToCategory(context, 'Tech Events'),
            ),
            _CategoryCard(
              image: 'assets/SAC.jpg',
              label: 'Cultural Events',
              onTap: () => _navigateToCategory(context, 'Cultural Events'),
            ),
            _CategoryCard(
              image: 'assets/SAC.jpg',
              label: 'Sports Events',
              onTap: () => _navigateToCategory(context, 'Sports Events'),
            ),
            _CategoryCard(
              image: 'assets/SAC.jpg',
              label: 'Workshops',
              onTap: () => _navigateToCategory(context, 'Workshops'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategory(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventListScreen(category: category)),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.image,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(
                image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            )
                          ],
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventListScreen extends StatelessWidget {
  final String category;

  const EventListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade700, Colors.blue.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
        itemCount: 10,
        itemBuilder: (context, index) => EventCard(
          eventTitle: '$category Event ${index + 1}',
          date: '${DateTime.now().add(Duration(days: index)).day}/'
              '${DateTime.now().add(Duration(days: index)).month}',
          location: 'Main Auditorium',
          image: 'assets/SAC.jpg',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsScreen(
                eventTitle: '$category Event ${index + 1}',
                date: '${DateTime.now().add(Duration(days: index)).day}/'
                    '${DateTime.now().add(Duration(days: index)).month}',
                location: 'Main Auditorium',
                image: 'assets/SAC.jpg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String eventTitle;
  final String date;
  final String location;
  final String image;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.eventTitle,
    required this.date,
    required this.location,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02), // Responsive margin
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  width: screenWidth * 0.25, // Responsive image width
                  height: screenWidth * 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: screenWidth * 0.03), // Responsive spacing
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple.shade800,
                          ),
                    ),
                    SizedBox(height: screenWidth * 0.02), // Responsive spacing
                    _EventDetailRow(
                      icon: Icons.calendar_today,
                      text: date,
                    ),
                    SizedBox(height: screenWidth * 0.01), // Responsive spacing
                    _EventDetailRow(
                      icon: Icons.location_on,
                      text: location,
                    ),
                    SizedBox(height: screenWidth * 0.02), // Responsive spacing
                    Row(
                      children: [
                        Chip(
                          backgroundColor: Colors.green.shade100,
                          label: const Text('Open'),
                        ),
                        const Spacer(),
                        Text(
                          'More Info',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventDetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _EventDetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02), // Responsive spacing
        Text(
          text,
          style: TextStyle(color: Colors.grey.shade700),
        ),
      ],
    );
  }
}

class EventDetailsScreen extends StatelessWidget {
  final String eventTitle;
  final String date;
  final String location;
  final String image;

  const EventDetailsScreen({
    super.key,
    required this.eventTitle,
    required this.date,
    required this.location,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade700, Colors.blue.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: eventTitle,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: screenHeight * 0.3, // Responsive image height
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Responsive spacing
            Text(
              eventTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade800,
                  ),
            ),
            SizedBox(height: screenHeight * 0.02), // Responsive spacing
            _DetailSection(
              icon: Icons.calendar_month,
              title: 'Date & Time',
              content: '$date • 10:00 AM - 5:00 PM',
            ),
            _DetailSection(
              icon: Icons.location_pin,
              title: 'Location',
              content: location,
            ),
            const _DetailSection(
              icon: Icons.info,
              title: 'Description',
              content: 'In today\'s fast-paced environment, innovation and collaboration drive success. '
    'At the forefront of technological advancements, creative minds unite to solve complex challenges '
    'and bring groundbreaking ideas to life. '
    'Through dedication, perseverance, and a commitment to excellence, obstacles become opportunities '
    'and visions transform into reality.',
            ),
            SizedBox(height: screenHeight * 0.03), // Responsive spacing
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.book_online),
                label: const Text('Register Now'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // Responsive padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.deepPurple.shade700,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _DetailSection({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02), // Responsive padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.deepPurple.shade700),
          SizedBox(width: screenWidth * 0.03), // Responsive spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                ),
                SizedBox(height: screenWidth * 0.01), // Responsive spacing
                Text(
                  content,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}