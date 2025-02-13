// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://aclub.onrender.com';

  /// Generic GET request handler that appends query parameters to the URL.
  static Future<dynamic> getRequest(
      String endpoint, Map<String, dynamic> queryParameters) async {
    try {
      // Build the complete URI with query parameters
      final uri = Uri.parse('$baseUrl/$endpoint')
          .replace(queryParameters: queryParameters);

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
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

  /// Fetch all events for a specific club using a GET request.
  static Future<List<dynamic>> getClubEvents(String clubId) async {
    return await getRequest('events/get-all-events', {'clubId': clubId});
  }

  /// Fetch all members for a specific club using a GET request.
  static Future<List<dynamic>> getClubMembers(String clubId) async {
    return await getRequest('participation/get-club-members', {'clubId': clubId});
  }
}
