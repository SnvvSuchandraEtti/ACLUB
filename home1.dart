// import 'package:flutter/material.dart';



// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your image path
//               radius: 18,
//             ),
//             SizedBox(width: 10),
//             Expanded(
//               child: TextField(
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.grey[850],
//                   hintText: 'Search on Kuku',
//                   hintStyle: TextStyle(color: Colors.grey),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   prefixIcon: Icon(Icons.search, color: Colors.grey),
//                 ),
//               ),
//             ),
//             SizedBox(width: 10),
//             Icon(Icons.translate, color: Colors.white),
//           ],
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(color: Colors.blue),
//               child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
//             ),
//             ListTile(
//               title: Text('Item 1'),
//               onTap: () {},
//             ),
//             ListTile(
//               title: Text('Item 2'),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20),
//             // Horizontal Banner Carousel
//             SizedBox(
//               height: 200,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   bannerCard('assets/secret_billionaire.jpg'),
//                   bannerCard('assets/movie_2.jpg'),
//                   bannerCard('assets/movie_3.jpg'),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             // Category Row
//             categoryRow(context),
//             SizedBox(height: 20),
//             // Continue Listening Section
//             sectionTitle('Continue Listening'),
//             listeningSection(),
//             SizedBox(height: 20),
//             // Top 20 Knowledge Section
//             sectionTitle('Top 20 Knowledge'),
//             knowledgeSection(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: bottomNavBar(),
//     );
//   }

//   // Widgets for Banner, Categories, Continue Listening, Knowledge, and Bottom Navigation Bar

//   Widget bannerCard(String imagePath) {
//     return Container(
//       margin: EdgeInsets.only(left: 16),
//       width: 300,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         image: DecorationImage(
//           image: AssetImage(imagePath),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Align(
//         alignment: Alignment.bottomRight,
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: CircleAvatar(
//             backgroundColor: Colors.white,
//             child: Icon(Icons.play_arrow, color: Colors.black),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget categoryRow(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           categoryItem('Bedtime Stories', Icons.nightlight_round),
//           categoryItem('Entertainment', Icons.movie),
//           categoryItem('సాహిత్యం', Icons.book),
//           categoryItem('Classics', Icons.library_books),
//         ],
//       ),
//     );
//   }

//   Widget categoryItem(String title, IconData icon) {
//     return Container(
//       margin: EdgeInsets.only(left: 16),
//       child: Column(
//         children: [
//           CircleAvatar(
//             backgroundColor: Colors.grey[850],
//             radius: 30,
//             child: Icon(icon, color: Colors.white, size: 30),
//           ),
//           SizedBox(height: 8),
//           Text(
//             title,
//             style: TextStyle(color: Colors.white, fontSize: 12),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget sectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//       child: Text(
//         title,
//         style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget listeningSection() {
//     return SizedBox(
//       height: 150,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           listeningCard('assets/ob/ob2.jpg', 'Episode 4/9'),
//           listeningCard('assets/ob/ob2.jpg', 'Episode 2/20'),
//           listeningCard('assets/ob/ob2.jpg', 'Episode 5/15'),
//         ],
//       ),
//     );
//   }

//   Widget listeningCard(String imagePath, String episode) {
//     return Container(
//       width: 150,
//       margin: EdgeInsets.only(left: 16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         image: DecorationImage(
//           image: AssetImage(imagePath),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Align(
//         alignment: Alignment.bottomLeft,
//         child: Container(
//           padding: EdgeInsets.all(8),
//           color: Colors.black54,
//           child: Text(
//             episode,
//             style: TextStyle(color: Colors.white, fontSize: 12),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget knowledgeSection() {
//     return SizedBox(
//       height: 150,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           knowledgeCard('assets/ob/ob1.jpg'),
//           knowledgeCard('assets/ob/ob1.jpg'),
//           knowledgeCard('assets/ob/ob1.jpg'),
//         ],
//       ),
//     );
//   }

//   Widget knowledgeCard(String imagePath) {
//     return Container(
//       width: 150,
//       margin: EdgeInsets.only(left: 16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         image: DecorationImage(
//           image: AssetImage(imagePath),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget bottomNavBar() {
//     return BottomNavigationBar(
//       backgroundColor: Colors.black,
//       selectedItemColor: Colors.white,
//       unselectedItemColor: Colors.grey,
//       type: BottomNavigationBarType.fixed,
//       items: [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//         BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'ClubBoxes'),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Space'),
//       ],
//     );
//   }
// }
