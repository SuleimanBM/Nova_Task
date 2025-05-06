import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:nova_task/features/tasks/presentation/screens/addtask_screen.dart";

class TaskCard extends StatefulWidget {
  final String id;
  final String title;
  final DateTime date;
  final String priority;
  final String description;

  const TaskCard({
    super.key,
    required this.id,
    required this.date,
    required this.priority,
    required this.title,
    required this.description,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddtaskScreen()));
      },
      child: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    textWidthBasis: TextWidthBasis.parent,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 17, 16, 16)),
                  ),
                ),
                Column(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? newValue) {
                        setState(() => _isChecked = newValue!);
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 17, 16, 16)),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriorityIndicator(widget.priority),
                Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    const SizedBox(width: 4),
                    Text(_formatDate(widget.date)),
                  ],
                )
              ],
            )
          ],
        ),
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
