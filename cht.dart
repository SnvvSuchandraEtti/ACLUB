// import 'package:flutter/material.dart';
//
// defaultPadding() => EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0);
// defaultRadius() => BorderRadius.circular(18.0);
// defaultSpacing() => SizedBox(height: 10.0);
//
// defaultTheme() => ThemeData(
//   scaffoldBackgroundColor: Color(0xFF121212),
//   primaryColor: Color(0xFF075E54),
//   accentColor: Color(0xFF25D366),
//   textTheme: TextTheme(
//     bodyText1: TextStyle(color: Colors.white, fontSize: 16),
//     bodyText2: TextStyle(color: Colors.grey.shade500, fontSize: 14),
//   ),
// );
//
// void main() => runApp(ChatApp());
//
// class ChatApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: defaultTheme(),
//       home: ChatScreen(),
//     );
//   }
// }
//
// class ChatScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chats'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {},
//           ),
//           PopupMenuButton(
//             icon: Icon(Icons.more_vert),
//             itemBuilder: (_) => [
//               PopupMenuItem(child: Text('New Group')),
//               PopupMenuItem(child: Text('Settings')),
//             ],
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ChatList(),
//           ),
//           ChatInputField(),
//         ],
//       ),
//     );
//   }
// }
//
// class ChatList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       reverse: true,
//       itemCount: messages.length,
//       itemBuilder: (context, index) {
//         final message = messages[index];
//         return Padding(
//           padding: defaultPadding(),
//           child: Align(
//             alignment:
//             message.isMe ? Alignment.centerRight : Alignment.centerLeft,
//             child: Container(
//               constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: message.isMe ? Theme.of(context).primaryColor : Colors.grey.shade800,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15),
//                   topRight: Radius.circular(15),
//                   bottomLeft: message.isMe ? Radius.circular(15) : Radius.zero,
//                   bottomRight: message.isMe ? Radius.zero : Radius.circular(15),
//                 ),
//               ),
//               child: Text(
//                 message.text,
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class ChatInputField extends StatefulWidget {
//   @override
//   _ChatInputFieldState createState() => _ChatInputFieldState();
// }
//
// class _ChatInputFieldState extends State<ChatInputField> {
//   final TextEditingController _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//       color: Colors.grey.shade900,
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.emoji_emotions_outlined),
//             onPressed: () {},
//           ),
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: 'Type a message...',
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.attach_file),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.camera_alt),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: () {
//               setState(() {
//                 if (_controller.text.isNotEmpty) {
//                   messages.insert(
//                     0,
//                     Message(text: _controller.text, isMe: true),
//                   );
//                   _controller.clear();
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Message {
//   final String text;
//   final bool isMe;
//   Message({required this.text, required this.isMe});
// }
//
// List<Message> messages = [
//   Message(text: "Hey there!", isMe: false),
//   Message(text: "Hi! What's up?", isMe: true),
//   Message(text: "Are you free today?", isMe: false),
//   Message(text: "Yeah, let's catch up!", isMe: true),
//   Message(text: "Great, see you!", isMe: false),
//   Message(text: "Looking forward!", isMe: true),
// ];
