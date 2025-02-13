import 'package:flutter/material.dart';


class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildGreetingSection(),
              const SizedBox(height: 20),
              _buildUpcomingEventsSection(),
              const SizedBox(height: 20),
              _buildClubsJoinedSection(),
              const SizedBox(height: 20),
              _buildNotificationsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }

  Widget _buildGreetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Welcome, User!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Here is an overview of your dashboard.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildUpcomingEventsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Events',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3, // Replace with dynamic event count
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.event, color: Colors.blueAccent),
                title: Text('Event ${index + 1}'),
                subtitle: const Text('Details about the event go here.'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to event details
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildClubsJoinedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Clubs You Joined',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3, // Replace with dynamic club count
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.group, color: Colors.green),
                title: Text('Club ${index + 1}'),
                subtitle: const Text('Details about the club go here.'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to club details
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5, // Replace with dynamic notification count
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.notifications, color: Colors.orange),
                title: Text('Notification ${index + 1}'),
                subtitle: const Text('Details about the notification.'),
                onTap: () {
                  // Handle notification tap
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
