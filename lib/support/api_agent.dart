import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiAgent {
  /// Generic GET request with automatic JSON decoding
  static Future<Map<String, dynamic>> getJson(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }

    return json.decode(response.body) as Map<String, dynamic>;
  }
}
