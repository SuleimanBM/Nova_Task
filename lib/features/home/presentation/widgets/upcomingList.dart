import "package:flutter/material.dart";
import "package:intl/intl.dart";
// class Upcoming{
//   final String title;
//   final DateTime date;
//   final PriorityLevel priority;

//   Upcoming{
//     required this.title,
//     required this.date,
//     required this.priority,
//   });
// }

// enum PriorityLevel { high, medium, low }

class UpcomingList extends StatelessWidget {
    final String title;
    final DateTime date;
    final String priority;

  const UpcomingList({
    super.key,
    required this.date,
    required this.priority,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
         color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        //border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 17, 16, 16)),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPriorityIndicator(priority),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 4),
                  Text(_formatDate(date)),
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

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
}
