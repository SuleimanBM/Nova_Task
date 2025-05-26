import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_task/features/tasks/presentation/screens/addtask_screen.dart';
import 'package:nova_task/features/tasks/presentation/widgets/statistics.dart';
import 'package:nova_task/features/tasks/presentation/widgets/taskCard.dart';
import 'package:nova_task/features/tasks/presentation/widgets/todaysTask.dart';
import 'package:nova_task/features/tasks/presentation/widgets/upcomingList.dart';
import "../bloc/taskBloc.dart";
import "../bloc/taskEvents.dart";
import "../bloc/taskState.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});

  List _getUpcomingTasks(tasks) {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day).add(Duration(days: 1));
    final end = start.add(Duration(days: 2)); // 3 days total, excluding today

    return tasks.where((t) {
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
    return BlocConsumer<TaskBloc, TaskState>(listener: (context, state) {
      if (state is TaskError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    }, builder: (context, state) {
      final bloc = BlocProvider.of<TaskBloc>(context);
      if (bloc == null) {
        return const Center(child: Text('Bloc not available'));
      }
      if (state is TaskLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TaskLoaded) {
        // if (state.tasks.isEmpty) {
        //   return const Center(child: Text("Task is empty"));
        // }
        final upcomingTask = _getUpcomingTasks(state.tasks);

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 245, 245, 245),
            title: Text('NovaTask',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<TaskBloc>.value(
                          value: bloc,
                          child:AddtaskScreen(task: null, pageName: "Add Task"),),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    size: 24.sp,
                  ))
            ],
            scrolledUnderElevation: 0.0,
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              24.verticalSpace,
              TodaysTask(task: state.tasks),
              24.verticalSpace,
              Statistics(
                completed: state.tasksStatistics!.completed.toString(),
                pending: state.tasksStatistics!.pending.toString(),
                overdue: state.tasksStatistics!.overdue.toString(),
              ),
              24.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 17, 16, 16),
                    ),
                  ),
                  16.verticalSpace,
                  Column(
                    children: (upcomingTask == null || upcomingTask.isEmpty)
                        ? [
                            Text(
                              "No upcoming tasks",
                              style:
                                  TextStyle(fontSize: 16.sp, color: Colors.grey),
                            ),
                          ]
                        : upcomingTask
                            .map((task) => TaskCard(task: task))
                            .toList(),
                  )

                ],
              )
            ],
          ),
        );
      }
      return Center(child: Text("Unexpected state", style: TextStyle(fontSize: 16.sp)));
    });
  }
}
