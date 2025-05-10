import 'package:nova_task/features/tasks/domain/entities/task.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String priority;
  final String category;
  final String status;
  final String subtasks;
  final bool isCompleted;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.priority,
    required this.category,
    required this.status,
    required this.subtasks,
    required this.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'])
          : DateTime.now(), // fallback if null
      time: json['time'] ?? '', // this might be missing in your API
      priority: json['priority'] ?? '',
      category: json['category'] ?? '',
      status: json['status'] ?? '',
      subtasks: json['subtasks'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'time': time,
      'priority': priority,
      'category': category,
      'status': status,
      'subtasks': subtasks,
      'isCompleted': isCompleted,
    };
  }

  // Task toEntity() => Task(
  //       id: id,
  //       title: title,
  //       description: description,
  //       date: date,
  //       time: time,
  //       priority: priority,
  //       category: category,
  //       subtasks: subtasks,
  //       isCompleted: isCompleted,
  //     );
}
