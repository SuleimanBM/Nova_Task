import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nova_task/features/tasks/data/models/taskStatistics.dart';
import '../models/taskModel.dart';

class RemoteTaskDataSource {
  final http.Client client;
  RemoteTaskDataSource(this.client);

  Future<List<TaskModel>> getTasks() async {
     try{
       print("💡 RemoteDataSource: starting fetch");
    final res = await client.get(
      Uri.parse('http://172.20.80.1:8000/todo/tasks'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODFhMzBlYzA2OWM3NTk3ZmI3Y2ZjN2QiLCJpYXQiOjE3NDY3MzE5MzUsImV4cCI6MTc0NzMzNjczNX0.BsLu-oHhE0sD0doagAq8cy7r8ZJolAw-lM-S7LSHvGo'
      },
    );
    print("💡 RemoteDataSource: got HTTP ${res.statusCode}");
    if (res.statusCode != 200) {
      throw Exception('Failed to load tasks');
    }
    print("response from server $res");
    //final List<dynamic> data = json.decode(res.body)['tasks'] as List<dynamic>;
    final Map<String, dynamic> jsonBody = json.decode(res.body);
  final List<dynamic> tasksJson = jsonBody['tasks'];
    return tasksJson
        .map((jsonMap) => TaskModel.fromJson(jsonMap as Map<String, dynamic>))
        .toList();
     }catch(e){
       print(e);
       throw Exception('Failed to load tasks');
     }
  }

  Future<Object> getTasksStatistics() async {
    print("getting tasks statistics");
    final res = await client.get(
      Uri.parse('http://172.20.80.1:8000/todo/tasks-statistics'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODFhMzBlYzA2OWM3NTk3ZmI3Y2ZjN2QiLCJpYXQiOjE3NDY3MzE5MzUsImV4cCI6MTc0NzMzNjczNX0.BsLu-oHhE0sD0doagAq8cy7r8ZJolAw-lM-S7LSHvGo'
      },
    );
    if (res.statusCode != 200) {
      throw Exception('Failed to load tasks');
    }
    print("response from server $res");
    final Map<String, dynamic> jsonBody = json.decode(res.body);
    final taskStatisticsJson = jsonBody['taskStats'];
    return TaskStatistics.fromJson(taskStatisticsJson) ;
    
  }
  Future<List<TaskModel>> getFilteredTasks({
    String? status,
    String? priority,
    String? category,
    bool? isCompleted,
    DateTime? date,
    String? sortBy,
    String? sortOrder = 'asc',
  }) async {
    
    final res = await client.get(
      Uri.parse('http://172.20.80.1:8000/todo/tasks?').replace(
    queryParameters: {
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (category != null) 'category': category,
      if (isCompleted != null) 'isCompleted': isCompleted.toString(),
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
    },
  ),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODFhMzBlYzA2OWM3NTk3ZmI3Y2ZjN2QiLCJpYXQiOjE3NDY3MzE5MzUsImV4cCI6MTc0NzMzNjczNX0.BsLu-oHhE0sD0doagAq8cy7r8ZJolAw-lM-S7LSHvGo'
      },
    );
    if (res.statusCode != 200) {
      throw Exception('Failed to load tasks');
    }
    print("response from server $res");
    //final List<dynamic> data = json.decode(res.body)['tasks'] as List<dynamic>;
    final Map<String, dynamic> jsonBody = json.decode(res.body);
    final List<dynamic> tasksJson = jsonBody['tasks'];
    return tasksJson
        .map((jsonMap) => TaskModel.fromJson(jsonMap as Map<String, dynamic>))
        .toList();
  }
}
