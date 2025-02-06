import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String profileImageUrl = 'assets/boy.png'; // Local asset path
  final String studentName = 'B Prudvi Satya Teja';
  final String rollNo = '22A91A0565';
  final String branch = 'CSE';
  final String campus = 'AEC';
  final String year = '3rd Year';
  final String clubMember = 'G D G';
  final int eventsParticipated = 5;

  bool _showEnlargedImage = false;

  void _toggleImageSize() {
    setState(() {
      _showEnlargedImage = !_showEnlargedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: screenSize.height * 0.20,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(40),
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              const Row(children: [Spacer()]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -60,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _toggleImageSize,
                        child: Hero(
                          tag: 'profile-image',
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.asset(
                                profileImageUrl,
                                width: 136,
                                height: 136,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.error, size: 50),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 40),
                  child: Column(
                    children: [
                      Text(
                        studentName,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[900],
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        clubMember,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            _buildInfoCard(
                              icon: Icons.badge,
                              title: "Roll No",
                              value: rollNo,
                              color: Colors.amber,
                            ),
                            _buildInfoCard(
                              icon: Icons.school,
                              title: "Branch",
                              value: branch,
                              color: Colors.purple,
                            ),
                            _buildInfoCard(
                              icon: Icons.location_city,
                              title: "Campus",
                              value: campus,
                              color: Colors.green,
                            ),
                            _buildInfoCard(
                              icon: Icons.calendar_today,
                              title: "Year",
                              value: year,
                              color: Colors.orange,
                            ),
                            _buildInfoCard(
                              icon: Icons.group,
                              title: "Club Member",
                              value: clubMember,
                              color: Colors.red,
                            ),
                            _buildInfoCard(
                              icon: Icons.event,
                              title: "Events",
                              value: eventsParticipated.toString(),
                              color: Colors.teal,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_showEnlargedImage)
            BackdropFilter(
              filter: ColorFilter.mode(
                Colors.black.withOpacity(0.8),
                BlendMode.srcOver,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: _toggleImageSize,
                      child: Center(
                        child: Hero(
                          tag: 'profile-image',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              profileImageUrl,
                              width: screenSize.width * 0.9,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => 
                                const Icon(Icons.error, size: 100),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      right: 30,
                      child: IconButton(
                        icon: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        onPressed: _toggleImageSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}