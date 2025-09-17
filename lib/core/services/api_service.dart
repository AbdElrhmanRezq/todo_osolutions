import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:todo_osolutions/models/task_model.dart';

class ApiService {
  final String projectId = dotenv.env['PROJECT_ID'] ?? '';
  final String anonKey = dotenv.env['ANON_KEY'] ?? '';
  final String baseUrl = 'supabase.co/rest/v1';

  Future<List<TaskModel>> getTasks() async {
    final url = Uri.parse('https://$projectId.$baseUrl/tasks');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $anonKey',
        'apikey': anonKey,
        "Content-Type": "application/json",
        "Prefer": "return=representation",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data);
      return data.map((e) => TaskModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}
