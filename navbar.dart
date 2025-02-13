import 'package:aclub/views/clubbox/chatscr.dart';
import 'package:aclub/views/home/myhome.dart';
import 'package:aclub/views/home/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PersistentBottomNavBar extends StatefulWidget {
  final int val; // 0 for normal user, 1 for admin
  const PersistentBottomNavBar({super.key, required this.val});

  @override
  _PersistentBottomNavBarState createState() => _PersistentBottomNavBarState();
}

class _PersistentBottomNavBarState extends State<PersistentBottomNavBar> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _updateScreens();
  }

  void _updateScreens() {
    _screens = widget.val == 0
        ? [
            const HomeScreen(),
            const ChatScreen(),
            const SizedBox(), // Placeholder for admin screen
            const ProfileScreen(),
          ]
        : [
            const HomeScreen(),
            const ChatScreen(),
            const ProfileScreen(),
          ];
  }

  List<BottomNavigationBarItem> _getNavItems() {
    if (widget.val == 1) {
      return [
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.message),
          label: 'Chats',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.setting),
          label: 'Admin',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.user),
          label: 'Profile',
        ),
      ];
    } else {
      return [
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.message),
          label: 'Chats',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.user),
          label: 'Profile',
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildWhatsAppStyleNavBar(),
    );
  }

  Widget _buildWhatsAppStyleNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      items: _getNavItems(),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF00A884), // WhatsApp green
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      iconSize: 28,
    );
  }
}