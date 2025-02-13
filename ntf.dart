import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Dummy notifications data
  List<String> notifications = [
    'You have a new message from John Doe.',
    'Your order #1234 has been shipped.',
    'Reminder: Meeting at 3 PM tomorrow.',
    'New comment on your post.',
    'Your subscription will expire soon.'
  ];

  // Remove a single notification at the given index
  void _removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle notificationTextStyle = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontSize: 16, color: Colors.black87);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.deepPurple,
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text(
                'No notifications',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(notifications[index], index, notificationTextStyle);
              },
            ),
    );
  }

  Widget _buildNotificationCard(String notification, int index, TextStyle textStyle) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background container for additional styling (optional gradient, etc.)
          Container(
            decoration: const BoxDecoration(
              // You can uncomment the following lines to add a subtle gradient background:
              // gradient: LinearGradient(
              //   colors: [Colors.white, Color(0xFFF7F7F7)],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Text(notification, style: textStyle),
          ),
          // Individual close button positioned at the top-right of the card
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () => _removeNotification(index),
              tooltip: 'Dismiss Notification',
            ),
          ),
        ],
      ),
    );
  }
}
