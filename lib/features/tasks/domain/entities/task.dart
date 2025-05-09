class Task {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String priority;
  final String category;
  final String subtasks;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.priority,
    required this.category,
    required this.subtasks,
    required this.isCompleted,
  });
}
