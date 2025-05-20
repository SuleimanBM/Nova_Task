import "dart:ffi";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nova_task/features/tasks/presentation/widgets/category_card.dart";
import "../bloc/taskBloc.dart";
import "../bloc/taskEvents.dart";
import "../bloc/taskState.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        title: Text(
          'Categories',
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
        scrolledUnderElevation: 0.0,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskLoaded) {
            final tasks = state.tasks;

            // Group tasks by category and count them
            final Map<String, int> categoryCounts = {};
            for (var task in tasks) {
              final category = task.category ?? 'Uncategorized';
              categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
            }

            final categoryList = categoryCounts.entries.toList();

            return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final maxWidth =
                          constraints.maxWidth; // Parent's available width
                      const spacing = 8.0;
// Calculate card width: (parentWidth - spacing) / 2
                      final cardWidth = (maxWidth - spacing) / 2;

                      return Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: spacing,
                        runSpacing: 4.0,
                        children: categoryList.isEmpty
                            ? [
                                const Center(
                                  
                                  child: Text("You have no categories"),
                                )
                              ]
                            : List.generate(categoryList.length, (index) {
                                final category = categoryList[index];
                                return CategoryCard(
                                  width: cardWidth,
                                  category: category.key,
                                  count: category.value,
                                );
                              }),
                      );
                    },
                  ),
                ]);
          }

          return const Center(child: Text("Something went wrong."));
        },
      ),
    );
  }
}
