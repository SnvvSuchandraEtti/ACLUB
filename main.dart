import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _searchQuery = '';

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ChatSearchDelegate(_updateSearchQuery),
                );
              },
            ),
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(child: Text('New Group')),
                  const PopupMenuItem(child: Text('New Broadcast')),
                  const PopupMenuItem(child: Text('Linked Devices')),
                  const PopupMenuItem(child: Text('Starred Messages')),
                  const PopupMenuItem(child: Text('Settings')),
                ];
              },
            ),
          ],
          backgroundColor: const Color(0xff128C7E),
          title: const Text('WhatsApp'),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Color(0xff128C7E),
            tabs: [
              Tab(
                icon: Icon(Icons.camera_alt_rounded),
                text: 'Camera',
              ),
              Tab(
                icon: Icon(Icons.chat),
                text: 'Chats',
              ),
              Tab(
                icon: Icon(Icons.circle_outlined),
                text: 'Status',
              ),
              Tab(
                icon: Icon(Icons.call_sharp),
                text: 'Calls',
              ),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black38,
          ),
        ),
        body: TabBarView(
          children: [
            const Center(child: Text('This feature is coming soon')),
            ChatsTab(searchQuery: _searchQuery),
            const Center(child: Text('Status feature is coming soon')),
            const Center(child: Text('Call feature is coming soon')),
          ],
        ),
      ),
    );
  }
}

class ChatSearchDelegate extends SearchDelegate {
  final Function(String) updateSearchQuery;

  ChatSearchDelegate(this.updateSearchQuery);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          updateSearchQuery(query);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Update the search query without calling setState
    updateSearchQuery(query);
    return Container(); // Replace with your search results widget
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Update the search query without calling setState
    updateSearchQuery(query);
    return Container(); // Replace with your suggestions widget
  }
}


class ChatsTab extends StatelessWidget {
  final String searchQuery;

  const ChatsTab({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chats = [
      {"title": "PM Garu", "message": "Good morning Modiji", "seen": Colors.blue, "image": "assets/Modi.jpg"},
      {"title": "Jeff Bezos", "message": "Wish I had given AMZN to you!", "seen": Colors.blue, "image": "assets/Bezos.jpg"},
      {"title": "Bill Gates", "message": "How were places in India", "seen": Colors.black38, "image": "assets/Billgates.png"},
      {"title": "Jack Ma", "message": "Babu Alibaba Ela undhi.", "seen": Colors.blue, "image": "assets/Jack.jpg"},
      {"title": "XI Jinping", "message": "Gabbilalu tindam Aapeyyi bro!", "seen": Colors.black38, "image": "assets/Jinping.jpg"},
      {"title": "Mark Zuckerberg", "message": "Will Meet Again with Meta Relaunch.", "seen": Colors.blue, "image": "assets/Mark.png"},
      {"title": "Musk Mama", "message": "India ki Eppudu vastav bro.", "seen": Colors.black38, "image": "assets/Musk.jpg"},
      {"title": "Satya Uncle", "message": "Windows jagaratha uncle.", "seen": Colors.blue, "image": "assets/Nadella.jpg"},
      {"title": "Russia PM Bolte", "message": "Endhuku bro Antha rakthapatham.", "seen": Colors.black38, "image": "assets/Putin.png"},
      {"title": "Google Sundar", "message": "Mastaru Nalamaa irukkingraar ka?", "seen": Colors.blue, "image": "assets/Sundar.png"},
      {"title": "🍎 CEO", "message": "Em sadistav bro antha rates tho?", "seen": Colors.black38, "image": "assets/Tim.jpg"},
      {"title": "Trumpu", "message": "Urgent ga president ayyipo mava!", "seen": Colors.blue, "image": "assets/Trump.png"},
    ];

    final filteredChats = chats.where((chat) {
      return chat['title'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: filteredChats.map((chat) {
            return SingleChatWidget(
              chatTitle: chat['title'],
              chatMessage: chat['message'],
              seenStatusColor: chat['seen'],
              imageUrl: chat['image'],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class SingleChatWidget extends StatelessWidget {
  final String chatTitle;
  final String chatMessage;
  final Color seenStatusColor;
  final String imageUrl;

  const SingleChatWidget({
    super.key,
    required this.chatTitle,
    required this.chatMessage,
    required this.seenStatusColor,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imageUrl),
      ),
      title: Text(chatTitle),
      subtitle: Text(chatMessage),
      trailing: Icon(
        Icons.done_all,
        color: seenStatusColor,
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Clicked on $chatTitle'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }
}
