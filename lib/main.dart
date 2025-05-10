import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_task/features/tasks/presentation/bloc/taskEvents.dart';
import 'package:nova_task/features/tasks/presentation/screens/categories_screen.dart';
import 'package:nova_task/features/tasks/presentation/screens/home_screen.dart';
import 'package:nova_task/features/tasks/presentation/screens/tasks_screen.dart';
import 'package:nova_task/features/dependencyInjection.dart';
import 'package:nova_task/features/tasks/presentation/bloc/taskBloc.dart';
import 'package:get_it/get_it.dart';
import "package:nova_task/features/dependencyInjection.dart" as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TaskBloc>()..add(LoadTasks()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      ),
    );
  }
}


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
          HomeScreen(),
          TasksScreen(),
          CategoriesScreen()
        ][currentPageIndex],
      ),

    );
  }
}
