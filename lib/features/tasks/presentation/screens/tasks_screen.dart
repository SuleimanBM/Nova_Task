import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nova_task/features/tasks/presentation/screens/addtask_screen.dart";
import 'package:nova_task/features/tasks/presentation/widgets/taskCard.dart';
import "../bloc/taskBloc.dart";
import "../bloc/taskEvents.dart";
import "../bloc/taskState.dart";

class TasksScreen extends StatelessWidget {
  TasksScreen({super.key});

  final List<Map<String, dynamic>> upcomingItems = [
    {
      "title": "Grocery Shopping for the week Grocery Shopping for the week",
      "date": DateTime.now().add(const Duration(days: 1)),
      "priority": "high",
    },
    {
      "title": "Prepare project presentation",
      "date": DateTime.now().add(const Duration(days: 3)),
      "priority": "medium",
    },
    {
      "title": "Team meeting",
      "date": DateTime.now().add(const Duration(days: 5)),
      "priority": 'low',
    },
    {
      "title": "Make a doctor's appointment",
      "date": DateTime.now().add(const Duration(days: 6)),
      "priority": "high",
    },
    {
      "title": "Buy a new pair of shoes",
      "date": DateTime.now().add(const Duration(days: 9)),
      "priority": "medium",
    },
    {
      "title": "Finish the book",
      "date": DateTime.now().add(const Duration(days: 10)),
      "priority": "low",
    },
    {
      "title": "Start a new project",
      "date": DateTime.now().add(const Duration(days: 12)),
      "priority": "high",
    },
  ];
@override
Widget build(BuildContext context) {
  return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
    print('Current State: $state');
    if (state is TaskLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is TaskLoaded ) {
      if (state.tasks.isEmpty) {
        return const Center(child: Text("Task is empty"));
      }
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          title: const Text('NovaTask',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
                onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddtaskScreen(task: null, pageName: "Add Task"),
                      ),
                    );
                    // Refresh data after returning
                    BlocProvider.of<TaskBloc>(context).add(LoadTasks());
                  },
                icon: const Icon(
                  Icons.add,
                  size: 32,
                ))
          ],
          scrolledUnderElevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Flexible(
                        child: SearchBar(
                          hintText: 'Search for tasks',
                          leading: Icon(Icons.search),
                          constraints: BoxConstraints(minHeight: 50),
                          elevation: WidgetStatePropertyAll(0.0),
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                      ),
                      SizedBox(width: 2),
                      IconButton(
                          onPressed: () async {
                            final String? filter = await showMenu<String>(
                                context: context,
                                position: RelativeRect.fromLTRB(0, 0, 0, 0),
                                items: [
                                  const PopupMenuItem<String>(
                                    value: 'priority',
                                    child: Text('Priority'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'status',
                                    child: Text('Status'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'completed',
                                    child: Text('Completed Only'),
                                  ),
                                ]);
                            if (filter != null) {
                              if (filter == 'priority') {
                                  context.read<TaskBloc>().add(FilterTasks(
                                      priority:
                                          'High')); // Or get priority from user input
                                } else if (filter == 'status') {
                                  context.read<TaskBloc>().add(FilterTasks(
                                      status:
                                          'To Do')); // Or get status from user input
                                } else if (filter == 'completed') {
                                  context
                                      .read<TaskBloc>()
                                      .add(FilterTasks(isCompleted: true));
                                }
                            }
                          },
                          icon: Icon(
                            Icons.filter_list,
                            size: 32,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                      task: state.tasks[index],
                      );
                    },
                  ),
                ],
              )),
        ),
      );
    } else {
      return const Center(child: Text("No tasks"));
    }
  });
}
}