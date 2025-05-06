import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        title: const Text('NovaTask',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {},
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
          child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                     Flexible(
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
                        onPressed: null,
                        icon: Icon(
                          Icons.filter_list,
                          size: 32,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
                  print('Current State: $state');
                  if (state is TaskLoading) {
                    print('Current State: $state');
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TaskLoaded) {
                    print('Current State: $state');
                      if (state.tasks.isEmpty) {
                      return const Center(
                          child: Text("Task is empty")); // ← this might be what you're seeing
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          id: state.tasks[index].id,
                          title: state.tasks[index].title,
                          description: state.tasks[index].description,
                          date: state.tasks[index].date,
                          priority: state.tasks[index].priority,
                        );
                      },
                    );
                  } else {
                    print('Current State: $state');
                    return const Center(child: Text("No tasks"));
                  }
                }),
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: upcomingItems.length,
                //   itemBuilder: (context, index) {
                //     return TaskCard(
                //       title: upcomingItems[index]['title'],
                //       date: upcomingItems[index]['date'],
                //       priority: upcomingItems[index]['priority'],
                //     );
                //   },
                // )
              ],
            )
        ),
      ),
    );
  }
}
