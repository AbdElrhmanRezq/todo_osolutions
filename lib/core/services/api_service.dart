import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String projectId = dotenv.env['PROJECT_ID'] ?? '';
  final String anonKey = dotenv.env['ANON_KEY'] ?? '';
  final String baseUrl = 'supabase.co/rest/v1/';

  Future<List<String>> getTargetBodyParts() async {
    final url = Uri.parse('https://${projectId}.${baseUrl}');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ANON_KEY',
        'apikey': anonKey,
        "Content-Type": "application/json",
        "Prefer": "return=representation",
      },
    );
    return [];
    // if (response.statusCode == 200) {
    //   final List<dynamic> data = jsonDecode(response.body);
    //   return data.map((e) => e.toString()).toList();
    // } else {
    //   throw Exception('Failed to load target muscles');
    // }
  }
}
