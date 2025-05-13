import "dart:ffi";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../bloc/taskBloc.dart";
import "../bloc/taskEvents.dart";
import "../bloc/taskState.dart";

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        title: const Text(
          'Categories',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
                        children: List.generate(categoryList.length, (index) {
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

class CategoryCard extends StatelessWidget {
  final double width;
  final String category;
  final int count;

  const CategoryCard({
    super.key,
    required this.width,
    required this.category,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: width,
      padding: const EdgeInsets.all(8),
      // ✅ Remove horizontal margin
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 17, 16, 16),
            ),
          ),
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 17, 16, 16),
            ),
          ),
        ],
      ),
    );
  }
}
