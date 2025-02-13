import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isLargeScreen = screenWidth > 600; // Adjust breakpoint as needed

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        shadowColor: Colors.black45,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? screenWidth * 0.2 : 16.0,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Get in Touch with Us',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'We would love to hear from you!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/logo/ACLUB.png',
                      height: screenHeight * 0.25,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Meet the Developers',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Divider(thickness: 2),
              const SizedBox(height: 20),
              DeveloperCard(
                name: 'Prudvi',
                role: 'Backend Developer',
                email: '22A91A0565@aec.edu.in',
                phone: '+91 97014 53495',
                imagePath: 'https://mobile.technicalhub.io:5010/student/22A91A0565.png',
              ),
              DeveloperCard(
                name: 'Suchandra',
                role: 'Frontend Developer',
                email: '22A91A0570@aec.edu.in',
                phone: '+91 79896 35988',
                imagePath: 'https://mobile.technicalhub.io:5010/student/22A91A0570.png',
              ),
              const SizedBox(height: 30),
              const Text(
                'Write to Us',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Divider(thickness: 2),
              const SizedBox(height: 20),
              ContactForm(),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Thank you for reaching out!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Developer Card Widget
class DeveloperCard extends StatelessWidget {
  final String name;
  final String role;
  final String email;
  final String phone;
  final String imagePath;

  const DeveloperCard({
    super.key,
    required this.name,
    required this.role,
    required this.email,
    required this.phone,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth > 600;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLargeScreen
            ? Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(imagePath),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildDetails(),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(imagePath),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildDetails(),
                ],
              ),
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          role,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.email, size: 18, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              email,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Icon(Icons.phone, size: 18, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              phone,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}

// Contact Form Widget
class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth > 600;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField('Your Name', _nameController, false),
          const SizedBox(height: 20),
          _buildTextField('Your Email', _emailController, true),
          const SizedBox(height: 20),
          _buildTextField('Your Message', _messageController, false, maxLines: 4),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Message Sent Successfully!')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: isLargeScreen ? 40 : 20,
                vertical: 12,
              ),
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, bool isEmail, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label.toLowerCase()';
        }
        if (isEmail && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}
