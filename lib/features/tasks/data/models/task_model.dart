import 'package:nova_task/features/tasks/domain/entities/task.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final DateTime time;
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
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['dueDate'] as String),
      time: DateTime.parse(json['time'] as String),
      priority: json['priority'] as String,
      category: json['category'] as String,
      status: json['status'] as String,
      subtasks: json['subtasks'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
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
