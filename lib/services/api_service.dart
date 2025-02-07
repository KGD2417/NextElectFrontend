import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final String baseUrl = "https://d58f-2401-4900-7db9-e2a5-808a-5e84-1d24-8ae8.ngrok-free.app";

  // Helper function to make HTTP requests
  static Future<http.Response> _request(String method, String endpoint, {dynamic body}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final uri = Uri.parse('$baseUrl/$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    switch (method) {
      case 'GET':
        return await http.get(uri, headers: headers);
      case 'POST':
        return await http.post(uri, headers: headers, body: jsonEncode(body));
      default:
        throw Exception('Unsupported HTTP method');
    }
  }

  // GET request
  static Future<dynamic> get(String endpoint) async {
    final response = await _request('GET', endpoint);
    return _handleResponse(response);
  }

  // POST request
  static Future<dynamic> post(String endpoint, dynamic body) async {
    final response = await _request('POST', endpoint, body: body);
    return _handleResponse(response);
  }

  // Handle the HTTP response
  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}