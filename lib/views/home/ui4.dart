// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
//
//
//
// class SkillVisaProfileScreen extends StatefulWidget {
//   @override
//   _SkillVisaProfileScreenState createState() => _SkillVisaProfileScreenState();
// }
//
// class _SkillVisaProfileScreenState extends State<SkillVisaProfileScreen> {
//   // Profile Data
//   final ProfileData profileData = ProfileData(
//     fullName: 'ETTI SN V V SUCHANDI',
//     nationality: 'Indian',
//     dateOfBirth: '01/01/1990',
//     passport: 'XXXXXXXX',
//     visaType: 'Skill Visa',
//   );
//
//   // Download Method
//   Future<void> downloadProfile() async {
//     try {
//       // Simulate PDF generation
//       final pdfBytes = await _generatePdfBytes();
//
//       // Get temporary directory
//       final tempDir = await getTemporaryDirectory();
//       final file = File('${tempDir.path}/skill_visa_profile.pdf');
//
//       // Write PDF bytes to file
//       await file.writeAsBytes(pdfBytes);
//
//       // Show success dialog
//       _showDownloadDialog(file.path);
//     } catch (e) {
//       _showErrorDialog('Download Failed', e.toString());
//     }
//   }
//
//   // Share Method
//   Future<void> shareProfile() async {
//     try {
//       // Simulate PDF generation
//       final pdfBytes = await _generatePdfBytes();
//
//       // Get temporary directory
//       final tempDir = await getTemporaryDirectory();
//       final file = File('${tempDir.path}/skill_visa_profile.pdf');
//
//       // Write PDF bytes to file
//       await file.writeAsBytes(pdfBytes);
//
//       // Share file
//       await Share.shareFiles([file.path], text: 'My Skill Visa Profile');
//     } catch (e) {
//       _showErrorDialog('Share Failed', e.toString());
//     }
//   }
//
//   // Simulate PDF Generation
//   Future<Uint8List> _generatePdfBytes() async {
//     // Placeholder for actual PDF generation logic
//     return Uint8List.fromList(utf8.encode('Skill Visa Profile Data'));
//   }
//
//   // Download Success Dialog
//   void _showDownloadDialog(String filePath) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Download Successful'),
//         content: Text('Profile downloaded to: $filePath'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Error Dialog
//   void _showErrorDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF89CFF0),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//         title: Text(
//           'Skill Visa',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.more_vert, color: Colors.black),
//             onPressed: () {
//               // Additional options
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Profile Image
//               Container(
//                 width: 150,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                   image: DecorationImage(
//                     image: NetworkImage('https://example.com/profile.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//
//               // Name
//               Text(
//                 profileData.fullName,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               SizedBox(height: 24),
//
//               // Profile Details Card
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       _buildDetailRow('Nationality', profileData.nationality),
//                       Divider(),
//                       _buildDetailRow('Date of Birth', profileData.dateOfBirth),
//                       Divider(),
//                       _buildDetailRow('Passport', profileData.passport),
//                       Divider(),
//                       _buildDetailRow('Visa Type', profileData.visaType),
//                     ],
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 24),
//
//               // Action Buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onPressed: downloadProfile,
//                     child: Text('Download'),
//                   ),
//                   SizedBox(width: 16),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onPressed: shareProfile,
//                     child: Text('Share'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[700],
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Profile Data Model
// class ProfileData {
//   final String fullName;
//   final String nationality;
//   final String dateOfBirth;
//   final String passport;
//   final String visaType;
//
//   ProfileData({
//     required this.fullName, required this.nationality,
//     required this.dateOfBirth,
//     required this.passport,
//     required this.visaType,
//   });
// }
