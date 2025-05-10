class TaskStatistics {
  final int completed;
  final int pending;
  final int overdue;

  const TaskStatistics({
    required this.completed,
    required this.pending,
    required this.overdue,
  });

  factory TaskStatistics.fromJson(Map<String, dynamic> json) {
    return TaskStatistics(
      completed: json['completed'] ?? 0,
      pending: json['pending'] ?? 0,
      overdue: json['overdue'] ?? 0,
    );
  }
}
