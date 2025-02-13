import 'package:flutter/material.dart';

/// Main Screen with Tabs
class ClubsScreena extends StatefulWidget {
  const ClubsScreena({super.key});

  @override
  State<ClubsScreena> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreena>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Three tabs: Event Details, Members, Feedback
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // You can further retrieve MediaQuery info here for responsive styling if needed.
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Club Event App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(
              text: 'Event Details',
              icon: Icon(Icons.event),
            ),
            Tab(
              text: 'Members',
              icon: Icon(Icons.group),
            ),
            Tab(
              text: 'Feedback',
              icon: Icon(Icons.feedback),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          EventDetailsTab(),
          MembersTab(),
          FeedbackTab(),
        ],
      ),
    );
  }
}

/// Tab 1: Event Details with an image, description, and two buttons.
class EventDetailsTab extends StatelessWidget {
  const EventDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rectangular container with event image
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/event_image.jpg'), // Replace with your event image asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Event basic info
          Text(
            'Event Title: Exciting Club Event',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Date: 25th Feb 2025 | Location: Auditorium',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          // Long description about the event
          Text(
            'Event Description:\n\n'
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at sem a massa lobortis consectetur. '
            'Quisque sagittis, sapien at blandit tincidunt, libero mauris volutpat odio, sed volutpat magna eros in libero. '
            'Ut tempus, risus vitae tristique posuere, massa quam egestas dolor, eget efficitur risus urna a ligula. '
            'In hac habitasse platea dictumst. Integer ac mi nec erat volutpat tincidunt non quis dui.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          // Two buttons: Give Feedback and Register
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to or show feedback functionality
                },
                child: const Text('Give Feedback'),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to registration functionality
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Tab 2: Registered Members UI with a header and list of member details.
class MembersTab extends StatelessWidget {
  const MembersTab({super.key});

  // Dummy member data list.
  final List<Map<String, String>> members = const [
    {
      'name': 'John Doe',
      'roll': '12345',
      'dept': 'CSE',
      'year': '3rd',
      'profile': 'assets/member1.jpg', // Replace with your member image asset
    },
    {
      'name': 'Jane Smith',
      'roll': '67890',
      'dept': 'ECE',
      'year': '2nd',
      'profile': 'assets/member2.jpg', // Replace with your member image asset
    },
    // Add more members as needed.
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          'Registered Members',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(member['profile']!),
                ),
                title: Text(member['name']!),
                subtitle: Text(
                  'Roll: ${member['roll']} | Dept: ${member['dept']} | Year: ${member['year']}',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Tab 3: Feedback UI showing event data and allowing users to submit feedback.
class FeedbackTab extends StatefulWidget {
  const FeedbackTab({super.key});

  @override
  State<FeedbackTab> createState() => _FeedbackTabState();
}

class _FeedbackTabState extends State<FeedbackTab> {
  final TextEditingController _feedbackController = TextEditingController();
  final List<String> feedbacks = [
    'Great event!',
    'Really enjoyed the presentation.',
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _addFeedback() {
    final text = _feedbackController.text;
    if (text.isNotEmpty) {
      setState(() {
        feedbacks.add(text);
      });
      _feedbackController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event data header (can be adjusted to include more info)
          Text(
            'Event: Exciting Club Event',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Date: 25th Feb 2025 | Location: Auditorium',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          // Feedback input area
          Text(
            'Your Feedback:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _feedbackController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your feedback here',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _addFeedback,
              child: const Text('Submit Feedback'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Feedback from others:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          // List of feedback messages
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(feedbacks[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
