import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://aclub.onrender.com";

  // Create a Club
  Future<Map<String, dynamic>> createClub(String name, String clubId, String? clubImage, String superAdmin) async {
    final url = Uri.parse("$baseUrl/clubs/create-club");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "clubId": clubId,
        "clubImage": clubImage,
        "superAdmin": superAdmin
      }),
    );
    return _handleResponse(response);
  }

  // Fetch All Clubs
  Future<List<dynamic>> getAllClubs() async {
    final url = Uri.parse("$baseUrl/clubs/get-all-clubs");
    final response = await http.get(url);
    return _handleResponse(response);
  }

  // Handle API Responses
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error: ${response.statusCode}");
    }
  }
}
