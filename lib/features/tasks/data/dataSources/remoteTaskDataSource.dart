import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nova_task/features/tasks/data/models/taskStatistics.dart';
import 'package:nova_task/features/tasks/domain/entities/task.dart';
import '../models/taskModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RemoteTaskDataSource {
  late final http.Client client;
  final _secureStorage = FlutterSecureStorage();

  static const String _baseUrl = 'https://novatask-server.onrender.com';

  String _token = '';

  // ✅ Private named constructor
  RemoteTaskDataSource._(this.client, this._token);

  // ✅ Factory method to create an instance
  static Future<RemoteTaskDataSource> create(http.Client client) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'authToken');
    print("Token fetched in taskremotedatasource form securestorage $token");
    if (token == null) throw Exception("Token not found");
    return RemoteTaskDataSource._(client, token);
  }

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
    String? sortOrder = 'asc',
    DateTime? date,
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
