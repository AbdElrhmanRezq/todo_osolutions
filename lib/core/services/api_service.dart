import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:todo_osolutions/models/category_model.dart';
import 'package:todo_osolutions/models/task_model.dart';

class ApiService {
  final String projectId = dotenv.env['PROJECT_ID'] ?? '';
  final String anonKey = dotenv.env['ANON_KEY'] ?? '';
  final String baseUrl = 'supabase.co/rest/v1';

  Future<List<TaskModel>> getTasks(List<String> filters) async {
    String filter = '';
    List<String> filtersPref = [
      "limit=",
      "offset=",
      "category_id=eq.",
      "completed=eq.",
      "priority=eq.",
      "order=created_at.",
    ];
    for (int i = 0; i < filters.length; i++) {
      if (filters[i] != '') {
        filter = filter + filtersPref[i] + filters[i];
      }
      if (i != filters.length - 1) {
        if (filters[i + 1] != '' && filter != '') {
          filter += '&';
        }
      }
    }
    final url = Uri.parse('https://$projectId.$baseUrl/tasks?$filter');
    print(url);

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

      return data.map((e) => TaskModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    final url = Uri.parse(
      'https://$projectId.$baseUrl/categories?order=name.asc',
    );

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
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<TaskModel> getSingleTask(String taskId) async {
    final url = Uri.parse('https://$projectId.$baseUrl/tasks?id=eq.$taskId');

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

      return data.map((e) => TaskModel.fromJson(e)).toList()[0];
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<List<TaskModel>> editTask(TaskModel task) async {
    try {
      final url = Uri.parse(
        'https://$projectId.$baseUrl/tasks?id=eq.${task.id}',
      );

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $anonKey',
          'apikey': anonKey,
          "Content-Type": "application/json",
          "Prefer": "return=representation",
        },
        body: jsonEncode({
          "title": task.title,
          "description": task.description,
          "priority": task.priority,
          "due_date": task.dueDate,
          "completed": task.completed,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => TaskModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to update tasks');
      }
    } catch (e) {
      throw Exception('Failed to update tasks: $e');
    }
  }

  Future<List<TaskModel>> deleteTask(TaskModel task) async {
    try {
      final url = Uri.parse(
        'https://$projectId.$baseUrl/tasks?id=eq.${task.id}',
      );

      final response = await http.delete(
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
        return data.map((e) => TaskModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to update tasks');
      }
    } catch (e) {
      throw Exception('Failed to update tasks: $e');
    }
  }
}
