import "package:flutter/material.dart";
import "package:nova_task/features/tasks/domain/entities/task.dart";

class TodaysTask extends StatefulWidget {
  final List task;
  TodaysTask({super.key, required this.task});

  @override
  State<TodaysTask> createState() => _TodaysTaskState();
}

class _TodaysTaskState extends State<TodaysTask> {
  late List todaysTask;

  @override
  void initState() {
    super.initState();
    _filtertask();
  }

  void _filtertask() {
    final today = DateTime.now();
    
    todaysTask = widget.task.where((t) {
      final taskDate = t.date is String
          ? DateTime.parse(t.date).toLocal()
          : t.date.toLocal();
           
      return taskDate.year == today.year &&
          taskDate.month == today.month &&
          taskDate.day == today.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 17, 16, 16)),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //border: Border.all(color: Colors.black, width: 1),
            ),
            child: todaysTask.isEmpty
                ? Container(
                    height: 200,
                    width: screenWidth * 1, // 80% of screen width
                    margin: const EdgeInsets.only(
                        right: 16), // spacing between items
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                        child: Text("No tasks today",
                            style: TextStyle(fontSize: 16))))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: todaysTask.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          width: screenWidth * 0.8, // 80% of screen width
                          margin: const EdgeInsets.only(
                              right: 16), // spacing between items
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  todaysTask[index].title,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 17, 16, 16),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  todaysTask[index].description,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 61, 61, 61),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]),
                        ),
                      );
                    },
                  )),
      ],
    );
  }
}
