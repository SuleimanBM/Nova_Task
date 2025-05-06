import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class RemoteTaskDataSource {
  final http.Client client;
  RemoteTaskDataSource(this.client);

  Future<List<TaskModel>> getTasks() async {
    final res = await client.get(
      Uri.parse('http://172.20.80.1:8000/todo/tasks'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODFhMzBlYzA2OWM3NTk3ZmI3Y2ZjN2QiLCJpYXQiOjE3NDY1NTcxNTksImV4cCI6MTc0NjU1ODA1OX0.Jm7HJWaJBTwQHDuPMIP6CK7vEbVCZmynkF7qyFmx1Ho'
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
