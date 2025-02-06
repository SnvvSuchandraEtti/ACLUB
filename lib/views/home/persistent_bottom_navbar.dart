import 'package:aclub/views/clubbox/chatscr.dart';
import 'package:aclub/views/home/myhome.dart';
import 'package:aclub/views/home/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';// Import your ProfileScreen

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _PersistentBottomNavBarState createState() => _PersistentBottomNavBarState();
}

class _PersistentBottomNavBarState extends State<NavBar> {
  int _currentIndex = 0; // Tracks the selected index for the bottom navigation bar

  // List of screens to display
  final List<Widget> _screens = [
    const HomeScreen(), // Replace with your home screen
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens, // Displays the selected screen
      ),
      bottomNavigationBar: _buildBottomAppBar(Theme.of(context)),
    );
  }

  Widget _buildBottomAppBar(ThemeData theme) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Iconsax.home, 
                color: _currentIndex == 0 ? theme.colorScheme.primary : Colors.grey.shade500),
              onPressed: () {
                setState(() {
                  _currentIndex = 0; // Switch to HomeScreen
                });
              },
            ),
            IconButton(
              icon: Icon(Iconsax.message, 
                color: _currentIndex == 1 ? theme.colorScheme.primary : Colors.grey.shade500),
              onPressed: () {
                setState(() {
                  _currentIndex = 1; // Switch to ChatScreen
                });
              },
            ),
            IconButton(
              icon: Icon(Iconsax.user, 
                color: _currentIndex == 2 ? theme.colorScheme.primary : Colors.grey.shade500),
              onPressed: () {
                setState(() {
                  _currentIndex = 2; // Switch to ProfileScreen
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}