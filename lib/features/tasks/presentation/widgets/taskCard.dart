import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:nova_task/features/tasks/domain/entities/task.dart";
import "package:nova_task/features/tasks/presentation/bloc/taskBloc.dart";
import "package:nova_task/features/tasks/presentation/screens/addtask_screen.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskCard extends StatefulWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool _isChecked;
  late String _title;
  late String _description;
  late String _priority;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    final task = widget.task;
    _isChecked = task.isCompleted;
    _title = task.title;
    _description = task.description;
    _priority = task.priority;
    _date = task.date;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
           final bloc = BlocProvider.of<TaskBloc>(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<TaskBloc>.value(
              value: bloc,
              child: AddtaskScreen(task: widget.task, pageName: "Edit Task"),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.sp),
        margin: EdgeInsets.only(bottom: 8.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _title,
                    textWidthBasis: TextWidthBasis.parent,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 17, 16, 16),
                    ),
                  ),
                ),
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() => _isChecked = newValue!);
                  },
                ),
              ],
            ),
            8.verticalSpace,
            Text(
              _description,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 17, 16, 16),
              ),
            ),
            8.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriorityIndicator(_priority),
                Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    4.horizontalSpace,
                    Text(_formatDate(_date), style: TextStyle(fontSize: 14.sp)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityIndicator(String priority) {
    final (color, text) = switch (priority.toLowerCase()) {
      "high" => (const Color.fromARGB(255, 209, 47, 35), 'High'),
      "medium" => (const Color.fromARGB(255, 247, 188, 52), 'Medium'),
      "low" => (const Color.fromARGB(255, 35, 204, 63), 'Low'),
      _ => throw ArgumentError('Invalid priority: $priority'),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
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
