import 'package:flutter/material.dart';
import 'package:nova_task/features/home/presentation/widgets/statistics.dart';
import 'package:nova_task/features/home/presentation/widgets/todaysTask.dart';
import 'package:nova_task/features/home/presentation/widgets/upcomingList.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Map<String, dynamic>> upcomingItems = [
    {
      "title": "Grocery Shopping for the week",
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
          // title: const Text('Home'),
          ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('NovaTask',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight
                          .bold)), // const Text('NovaTask', style: TextStyle(fontSize: 32),),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          const TodaysTask(),
          const SizedBox(
            height: 24,
          ),
          const Statistics(),
          const SizedBox(
            height: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Upcoming",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 16, 16),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: upcomingItems.length,
                itemBuilder: (context, index) {
                  return UpcomingList(
                    title: upcomingItems[index]['title'],
                    date: upcomingItems[index]['date'],
                    priority: upcomingItems[index]['priority'],
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
