import 'dart:convert';
import 'package:http/http.dart' as http;

const baseUrl = "http://10.0.2.2:8000"; // Android Emulator

class ApiService {
  static Future<Map<String, dynamic>> getAIPrediction() async {
    final res = await http.get(Uri.parse("$baseUrl/ai/predict"));
    return json.decode(res.body);
  }

  static Future<Map<String, dynamic>> getWhales() async {
    final res = await http.get(Uri.parse("$baseUrl/whales"));
    return json.decode(res.body);
  }
}
