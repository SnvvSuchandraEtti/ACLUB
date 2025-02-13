import 'package:flutter/material.dart';


class TeamPage extends StatelessWidget {
  final List<TeamMember> teamMembers = [
    TeamMember(
      name: 'Dhanunjay',
      role: 'Organizer',
      department: 'Computer Science',
      imageUrl: 'https://info.aec.edu.in/AEC/StudentPhotos/22a91a0571.jpg',
      socialLinks: SocialLinks(facebook: '#', twitter: '#', linkedin: '#'),
    ),
    TeamMember(
      name: 'Prudvi',
      role: 'Organizer',
      department: 'Computer Science',
      imageUrl: 'https://info.aec.edu.in/AEC/StudentPhotos/22a91a0565.jpg',
      socialLinks: SocialLinks(facebook: '#', twitter: '#', linkedin: '#'),
    ),
    TeamMember(
      name: 'Suchandra',
      role: 'Organizer',
      department: 'Computer Science',
      imageUrl: 'https://info.aec.edu.in/AEC/StudentPhotos/22a91a0570.jpg',
      socialLinks: SocialLinks(facebook: '#', twitter: '#', linkedin: '#'),
    ),
  ];

   TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {},
        // ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: teamMembers.length,
        itemBuilder: (context, index) {
          return TeamMemberCard(member: teamMembers[index]);
        },
      ),
    );
  }
}

class TeamMember {
  final String name;
  final String role;
  final String department;
  final String imageUrl;
  final SocialLinks socialLinks;

  TeamMember({
    required this.name,
    required this.role,
    required this.department,
    required this.imageUrl,
    required this.socialLinks,
  });
}

class SocialLinks {
  final String facebook;
  final String twitter;
  final String linkedin;

  SocialLinks({required this.facebook, required this.twitter, required this.linkedin});
}

class TeamMemberCard extends StatelessWidget {
  final TeamMember member;

  const TeamMemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(member.imageUrl),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(member.role, style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
                      SizedBox(width: 8),
                      Text(member.department, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.facebook, color: Colors.blue),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.backpack, color: Colors.lightBlue),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.link, color: Colors.blueAccent),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
