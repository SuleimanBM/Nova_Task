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
      completed: json['completed'],
      pending: json['pending'],
      overdue: json['overdue'],
    );
  }
}
