import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nova_task/features/tasks/presentation/screens/addtask_screen.dart";
import "package:nova_task/features/tasks/presentation/screens/home_screen.dart";
import 'package:nova_task/features/tasks/presentation/widgets/taskCard.dart';
import "../bloc/taskBloc.dart";
import "../bloc/taskEvents.dart";
import "../bloc/taskState.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      print('Current State: $state');
      if (state is TaskLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TaskLoaded) {
           final bloc = BlocProvider.of<TaskBloc>(context);
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 245, 245, 245),
            title: Text('NovaTask',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
            actions: [
              IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                     MaterialPageRoute(
                        builder: (context) => BlocProvider<TaskBloc>.value(
                          value: bloc,
                          child:
                              AddtaskScreen(task: null, pageName: "Add Task"),
                        ),
                      ),
                    );
                    // Refresh data after returning
                    BlocProvider.of<TaskBloc>(context).add(LoadTasks());
                  },
                  icon: Icon(
                    Icons.add,
                    size: 20.sp,
                  ))
            ],
            scrolledUnderElevation: 0.0,
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 24.0.sp),
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: SearchBar(
                            hintText: 'Search for tasks',
                            hintStyle: WidgetStateProperty.all<TextStyle?>(
                              TextStyle(fontSize: 14.sp),
                            ),
                            leading: Icon(Icons.search, size: 16.sp),
                            constraints: BoxConstraints(minHeight: 50.h),
                            elevation: const WidgetStatePropertyAll(0.0),
                            backgroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                          ),
                        ),
                        2.horizontalSpace,
                        IconButton(
                            onPressed: () async {
                              final String? filter = await showMenu<String>(
                                  context: context,
                                  position: RelativeRect.fromLTRB(0, 0, 0, 0),
                                  items: [
                                    PopupMenuItem<String>(
                                      value: 'priority',
                                      child: Text('Priority',
                                          style: TextStyle(fontSize: 12.sp)),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'status',
                                      child: Text('Status',
                                          style: TextStyle(fontSize: 12.sp)),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'completed',
                                      child: Text('Completed Only',
                                          style: TextStyle(fontSize: 12.sp)),
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
                              size: 32.sp,
                            ))
                      ],
                    ),
                    16.verticalSpace,
                    state.tasks.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.tasks.length,
                            itemBuilder: (context, index) {
                              return TaskCard(task: state.tasks[index]);
                            },
                          )
                        : Center(
                            child: Padding(
                              padding: EdgeInsets.all(24.0.sp),
                              child: Text(
                                "No tasks available",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color.fromARGB(255, 80, 80, 80)),
                              ),
                            ),
                          )
                  ],
                )),
          ),
        );
      } else {
        return Center(
            child: Text("No tasks", style: TextStyle(fontSize: 16.sp)));
      }
    });
  }
}
