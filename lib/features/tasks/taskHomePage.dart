import 'package:flutter/material.dart';
import 'package:nova_task/features/tasks/presentation/screens/categories_screen.dart';
import 'package:nova_task/features/tasks/presentation/screens/home_screen.dart';
import 'package:nova_task/features/tasks/presentation/screens/tasks_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      // appBar: AppBar(
      //   title: const Text('NovaTask'),
      // ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: [
          Builder(builder: (context) => HomeScreen()),
          TasksScreen(),
          CategoriesScreen()
        ][currentPageIndex],
      ),
    );
  }
}
