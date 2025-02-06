import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Event Model
class Event {
  final String id;
  final String name;
  final DateTime date;
  final String location;
  final String image;
  final String description;
  final List<String> guests;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.image,
    required this.description,
    required this.guests,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      name: json['eventName'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      image: json['image'] ?? 'assets/logo/A_CLUB.png',
      description: json['details'] ?? 'No description available',
      guests: List<String>.from(json['guest'] ?? []),
    );
  }
}

// API Service
class EventService {
  static const String _baseUrl = 'https://aclub.onrender.com';
  static const Map<String, String> _endpoints = {
    'all': 'events/get-all-events',
    'ongoing': 'events/ongoing-events',
    'upcoming': 'events/upcoming-events',
    'past': 'events/past-events',
  };

  // Fetch events based on type
  static Future<List<Event>> getEvents(String type) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/${_endpoints[type]}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'clubId': 'GDG'}),
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => Event.fromJson(e))
          .toList();
    }
    throw Exception('Failed to load events');
  }
}

// Main Events Screen
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
  
   static Container _buildGradient() => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade700, Colors.blue.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ); 
}



class _EventsScreenState extends State<EventsScreen> {
  late Future<List<Event>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = EventService.getEvents('all');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Events'),
        centerTitle: true,
        flexibleSpace: EventsScreen._buildGradient(),
      ),
      body: FutureBuilder<List<Event>>(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return _buildEventGrid(snapshot.data!);
        },
      ),
    );
  }

  Widget _buildEventGrid(List<Event> events) {
    return GridView.builder(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        childAspectRatio: 0.8,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: events.length,
      itemBuilder: (context, index) => _EventCard(
        event: events[index],
        onTap: () => _navigateToDetails(context, events[index]),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, Event event) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => EventDetailsScreen(event: event),
    ));
  }

  // Static method to build gradient background
  static Container _buildGradient() => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade700, Colors.blue.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  );
}

// Event Card Widget
class _EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const _EventCard({required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(event.image, fit: BoxFit.cover, height: 120, width: double.infinity),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.name, style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4),
                  Text('${event.date.day}/${event.date.month}/${event.date.year}', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 4),
                  Text(event.location, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Event Details Screen
class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
        flexibleSpace: EventsScreen._buildGradient(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(event.image, fit: BoxFit.cover, height: 200, width: double.infinity),
            ),
            SizedBox(height: 16),
            Text(event.name, style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 8),
            Text('Date: ${event.date.day}/${event.date.month}/${event.date.year}', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Text('Location: ${event.location}', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16),
            Text('Description:', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Text(event.description),
            SizedBox(height: 16),
            Text('Guests:', style: Theme.of(context).textTheme.titleLarge),
            ...event.guests.map((guest) => Text(guest)).toList(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle registration logic here
                _showRegistrationDialog(context);
              },
              child: const Text('Register Now'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRegistrationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Register for Event'),
          content: const Text('You have successfully registered for this event!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// Detail Section Widget
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











// import 'package:flutter/material.dart';

// class Eventscr extends StatelessWidget {
//   const Eventscr({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Event Categories',
//           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//               ),
//         ),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.deepPurple.shade700, Colors.blue.shade700],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
//         child: GridView.count(
//           crossAxisCount: screenWidth > 600 ? 3 : 2, // Adjust columns for tablets
//           mainAxisSpacing: screenHeight * 0.02, // Responsive spacing
//           crossAxisSpacing: screenWidth * 0.03,
//           childAspectRatio: screenWidth > 600 ? 0.8 : 0.9, // Adjust aspect ratio for tablets
//           children: [
//             _CategoryCard(
//               image: 'assets/logo/A_CLUB.png',
//               label: 'Tech Events',
//               onTap: () => _navigateToCategory(context, 'Tech Events'),
//             ),
//             _CategoryCard(
//               image: 'assets/logo/A_CLUB.png',
//               label: 'Cultural Events',
//               onTap: () => _navigateToCategory(context, 'Cultural Events'),
//             ),
//             _CategoryCard(
//               image: 'assets/logo/A_CLUB.png',
//               label: 'Sports Events',
//               onTap: () => _navigateToCategory(context, 'Sports Events'),
//             ),
//             _CategoryCard(
//               image: 'assets/logo/A_CLUB.png',
//               label: 'Workshops',
//               onTap: () => _navigateToCategory(context, 'Workshops'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _navigateToCategory(BuildContext context, String category) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => EventListScreen(category: category)),
//     );
//   }
// }

// class _CategoryCard extends StatelessWidget {
//   final String image;
//   final String label;
//   final VoidCallback onTap;

//   const _CategoryCard({
//     required this.image,
//     required this.label,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Stack(
//             children: [
//               Image.asset(
//                 image,
//                 width: double.infinity,
//                 height: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
//                   child: Text(
//                     label,
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           shadows: [
//                             Shadow(
//                               color: Colors.black.withOpacity(0.5),
//                               blurRadius: 4,
//                               offset: const Offset(2, 2),
//                             )
//                           ],
//                         ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class EventListScreen extends StatelessWidget {
//   final String category;

//   const EventListScreen({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(category),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.deepPurple.shade700, Colors.blue.shade700],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
//         itemCount: 10,
//         itemBuilder: (context, index) => EventCard(
//           eventTitle: '$category Event ${index + 1}',
//           date: '${DateTime.now().add(Duration(days: index)).day}/'
//               '${DateTime.now().add(Duration(days: index)).month}',
//           location: 'Main Auditorium',
//           image: 'assets/logo/A_CLUB.png',
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EventDetailsScreen(
//                 eventTitle: '$category Event ${index + 1}',
//                 date: '${DateTime.now().add(Duration(days: index)).day}/'
//                     '${DateTime.now().add(Duration(days: index)).month}',
//                 location: 'Main Auditorium',
//                 image: 'assets/logo/A_CLUB.png',
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class EventCard extends StatelessWidget {
//   final String eventTitle;
//   final String date;
//   final String location;
//   final String image;
//   final VoidCallback onTap;

//   const EventCard({
//     super.key,
//     required this.eventTitle,
//     required this.date,
//     required this.location,
//     required this.image,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Card(
//       elevation: 2,
//       margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02), // Responsive margin
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(15),
//         child: Padding(
//           padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.asset(
//                   image,
//                   width: screenWidth * 0.25, // Responsive image width
//                   height: screenWidth * 0.25,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(width: screenWidth * 0.03), // Responsive spacing
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       eventTitle,
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.deepPurple.shade800,
//                           ),
//                     ),
//                     SizedBox(height: screenWidth * 0.02), // Responsive spacing
//                     _EventDetailRow(
//                       icon: Icons.calendar_today,
//                       text: date,
//                     ),
//                     SizedBox(height: screenWidth * 0.01), // Responsive spacing
//                     _EventDetailRow(
//                       icon: Icons.location_on,
//                       text: location,
//                     ),
//                     SizedBox(height: screenWidth * 0.02), // Responsive spacing
//                     Row(
//                       children: [
//                         Chip(
//                           backgroundColor: Colors.green.shade100,
//                           label: const Text('Open'),
//                         ),
//                         const Spacer(),
//                         Text(
//                           'More Info',
//                           style: TextStyle(
//                             color: Colors.blue.shade700,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const Icon(Icons.arrow_forward_ios, size: 16),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _EventDetailRow extends StatelessWidget {
//   final IconData icon;
//   final String text;

//   const _EventDetailRow({required this.icon, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: Colors.grey.shade600),
//         SizedBox(width: MediaQuery.of(context).size.width * 0.02), // Responsive spacing
//         Text(
//           text,
//           style: TextStyle(color: Colors.grey.shade700),
//         ),
//       ],
//     );
//   }
// }

// class EventDetailsScreen extends StatelessWidget {
//   final String eventTitle;
//   final String date;
//   final String location;
//   final String image;

//   const EventDetailsScreen({
//     super.key,
//     required this.eventTitle,
//     required this.date,
//     required this.location,
//     required this.image,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.deepPurple.shade700, Colors.blue.shade700],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Hero(
//               tag: eventTitle,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Image.asset(
//                   image,
//                   width: double.infinity,
//                   height: screenHeight * 0.3, // Responsive image height
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.02), // Responsive spacing
//             Text(
//               eventTitle,
//               style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple.shade800,
//                   ),
//             ),
//             SizedBox(height: screenHeight * 0.02), // Responsive spacing
//             _DetailSection(
//               icon: Icons.calendar_month,
//               title: 'Date & Time',
//               content: '$date • 10:00 AM - 5:00 PM',
//             ),
//             _DetailSection(
//               icon: Icons.location_pin,
//               title: 'Location',
//               content: location,
//             ),
//             const _DetailSection(
//               icon: Icons.info,
//               title: 'Description',
//               content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
//                   'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
//                   'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
//             ),
//             SizedBox(height: screenHeight * 0.03), // Responsive spacing
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.book_online),
//                 label: const Text('Register Now'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // Responsive padding
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   backgroundColor: Colors.deepPurple.shade700,
//                 ),
//                 onPressed: () {},
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class _DetailSection extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String content;

//   const _DetailSection({
//     required this.icon,
//     required this.title,
//     required this.content,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02), // Responsive padding
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 28, color: Colors.deepPurple.shade700),
//           SizedBox(width: screenWidth * 0.03), // Responsive spacing
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey.shade800,
//                       ),
//                 ),
//                 SizedBox(height: screenWidth * 0.01), // Responsive spacing
//                 Text(
//                   content,
//                   style: TextStyle(
//                     color: Colors.grey.shade700,
//                     height: 1.4,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }