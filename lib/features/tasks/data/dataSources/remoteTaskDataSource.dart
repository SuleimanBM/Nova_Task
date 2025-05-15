import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nova_task/features/tasks/data/models/taskStatistics.dart';
import 'package:nova_task/features/tasks/domain/entities/task.dart';
import '../models/taskModel.dart';


class RemoteTaskDataSource {
  final http.Client client;
  RemoteTaskDataSource(this.client);

  static const String _baseUrl = 'https://novatask-server.onrender.com';
  static const String _localUrl =
      'http://172.20.80.1:8000'; // Used only for `addTask`

  static const String _token =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODFhMzBlYzA2OWM3NTk3ZmI3Y2ZjN2QiLCJpYXQiOjE3NDczNDE0NDksImV4cCI6MTc0Nzk0NjI0OX0.7RK-qKq0mCroREAAFZvApr8jnlrZXje2Oea_kuXluvE';

  Map<String, String> get _headers => {
        'Authorization': _token,
        'Content-Type': 'application/json',
      };

  Future<List<TaskModel>> getTasks() async {
    try {
      final res = await client.get(Uri.parse('$_baseUrl/todo/tasks'),
          headers: _headers);
      if (res.statusCode != 200) {
        throw Exception('Failed to load tasks: ${res.statusCode}');
      }

      final jsonBody = json.decode(res.body);
      final List<dynamic> tasksJson = jsonBody['tasks'];
      return tasksJson.map((json) => TaskModel.fromJson(json)).toList();
    } catch (e) {
      print("❌ Error getting tasks: $e");
      rethrow;
    }
  }

  Future<TaskStatistics> getTasksStatistics() async {
    try {
      final res = await client.get(Uri.parse('$_baseUrl/todo/tasks-statistics'),
          headers: _headers);
      if (res.statusCode != 200) {
        throw Exception('Failed to load task statistics: ${res.statusCode}');
      }

      final jsonBody = json.decode(res.body);
      return TaskStatistics.fromJson(jsonBody['taskStats']);
    } catch (e) {
      print("❌ Error getting task statistics: $e");
      rethrow;
    }
  }

  Future<List<TaskModel>> getFilteredTasks({
    String? status,
    String? priority,
    String? category,
    bool? isCompleted,
    String? sortBy,
    String? sortOrder = 'asc', DateTime? date,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/todo/tasks').replace(
        queryParameters: {
          if (status != null) 'status': status,
          if (priority != null) 'priority': priority,
          if (category != null) 'category': category,
          if (isCompleted != null) 'isCompleted': isCompleted.toString(),
          if (sortBy != null) 'sortBy': sortBy,
          if (sortOrder != null) 'sortOrder': sortOrder,
        },
      );

      final res = await client.get(uri, headers: _headers);
      if (res.statusCode != 200) {
        throw Exception('Failed to load filtered tasks: ${res.statusCode}');
      }

      final jsonBody = json.decode(res.body);
      final List<dynamic> tasksJson = jsonBody['tasks'];
      return tasksJson.map((json) => TaskModel.fromJson(json)).toList();
    } catch (e) {
      print("❌ Error filtering tasks: $e");
      rethrow;
    }
  }

  Future<TaskModel> addTask(Task task) async {
    try {
      final uri = Uri.parse('$_baseUrl/todo/tasks');

      final response = await client.post(
        uri,
        headers: _headers,
        body: jsonEncode({
          'title': task.title,
          'description': task.description,
          'dueDate': task.date.toIso8601String(),
          'time': task.time,
          'priority': task.priority,
          'status': "Pending",
          'category': task.category,
          'subtasks': task.subtasks,
          'isCompleted': task.isCompleted,
        }),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Failed to add task: ${response.body}');
      }

      return TaskModel.fromJson(json.decode(response.body));
    } catch (e) {
      print("❌ Error adding task: $e");
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      final uri = Uri.parse('$_baseUrl/todo/tasks/$taskId');
      final response = await client.delete(uri, headers: _headers);

      if (response.statusCode != 200) {
        throw Exception('Failed to delete task: ${response.body}');
      }

      print('✅ Task deleted successfully');
    } catch (e) {
      print('❌ Error deleting task: $e');
      rethrow;
    }
  }
}
