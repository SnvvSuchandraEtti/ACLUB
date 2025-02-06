import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://aclub.onrender.com';

  // Generic POST request handler
  static Future<dynamic> postRequest(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }

  // Specific event endpoints
  static Future<List<dynamic>> getClubEvents(String clubId) async {
    return await postRequest('events/get-all-events', {'clubId': clubId});
  }

  static Future<List<dynamic>> getClubMembers(String clubId) async {
    return await postRequest('participation/get-club-members', {'clubId': clubId});
  }
}