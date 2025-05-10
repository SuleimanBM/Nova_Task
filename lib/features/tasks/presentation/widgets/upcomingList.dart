import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:nova_task/features/tasks/domain/entities/task.dart";

class UpcomingList extends StatefulWidget {
  final List tasks;

  const UpcomingList({super.key, required this.tasks});

  @override
  State<UpcomingList> createState() => _UpcomingListState();
}

class _UpcomingListState extends State<UpcomingList> {
  late List<Task> upcomingTask;

  @override
  void initState() {
    super.initState();
    upcomingTask = _getUpcomingTasks() as List<Task>;
  }

  List _getUpcomingTasks() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day).add(Duration(days: 1));
    final end = start.add(Duration(days: 2)); // 3 days total, excluding today

    return widget.tasks.where((t) {
      final taskDate = t.date is String
          ? DateTime.parse(t.date).toLocal()
          : t.date.toLocal();

      final taskDateOnly =
          DateTime(taskDate.year, taskDate.month, taskDate.day);
      print("Task date only $taskDateOnly");
      return taskDateOnly.isAfter(start.subtract(const Duration(days: 1))) &&
          taskDateOnly.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
     return ListView.builder(
      itemCount: upcomingTask.length,
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // remove if you want scrolling
      itemBuilder: (context, index) {
        return _TaskCard(task: upcomingTask[index]);
      },
    );
  }

  Widget _buildPriorityIndicator(priority) {
    final (color, text) = switch (priority.toLowerCase()) {
      "high" => (const Color.fromARGB(255, 209, 47, 35), 'High'),
      "medium" => (const Color.fromARGB(255, 247, 188, 52), 'Medium'),
      "low" => (const Color.fromARGB(255, 35, 204, 63), 'Low'),
      _ => throw ArgumentError('Invalid priority: $priority'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
}

class _TaskCard extends StatelessWidget {
  final dynamic task;

  const _TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 17, 16, 16),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPriorityIndicator(task.priority),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 4),
                  Text(_formatDate(task.date)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPriorityIndicator(priority) {
    final (color, text) = switch (priority.toLowerCase()) {
      "high" => (const Color.fromARGB(255, 209, 47, 35), 'High'),
      "medium" => (const Color.fromARGB(255, 247, 188, 52), 'Medium'),
      "low" => (const Color.fromARGB(255, 35, 204, 63), 'Low'),
      _ => throw ArgumentError('Invalid priority: $priority'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  String _formatDate(date) {
    final parsedDate = date is String ? DateTime.parse(date) : date;
    return DateFormat('MMM dd, yyyy').format(parsedDate);
  }
}
