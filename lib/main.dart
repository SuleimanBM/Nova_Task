import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nova_task/features/tasks/presentation/bloc/taskEvents.dart';
import 'package:nova_task/features/tasks/presentation/screens/categories_screen.dart';
import 'package:nova_task/features/tasks/presentation/screens/home_screen.dart';
import 'package:nova_task/features/tasks/presentation/screens/tasks_screen.dart';
import 'package:nova_task/features/dependencyInjection.dart';
import 'package:nova_task/features/tasks/presentation/bloc/taskBloc.dart';
import 'package:get_it/get_it.dart';
import "package:nova_task/features/dependencyInjection.dart" as di;
import 'package:nova_task/features/tasks/taskHomePage.dart';
import 'package:nova_task/features/users/presentation/bloc/authBloc.dart';
import 'package:nova_task/features/users/presentation/bloc/authState.dart';
import 'package:nova_task/features/users/presentation/screens/loginScreen.dart';
import 'package:nova_task/features/users/presentation/screens/signupScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
         return BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  // Wrap TaskBloc *inside* the success state
                  return BlocProvider<TaskBloc>(
                    create: (_) => sl<TaskBloc>()..add(LoadTasks()),
                    child: MyHomePage(),
                  );
                } else {
                  return const LoginScreen();
                }
              },
            ),
          ),
        );
        // return MultiBlocProvider(
        //   providers: [
        //     BlocProvider<TaskBloc>(
        //       create: (_) => di.sl<TaskBloc>()..add(LoadTasks()),
        //     ),
        //     BlocProvider<AuthBloc>(
        //       create: (_) => di.sl<AuthBloc>(),
        //     ),
        //   ],
        //   child: MaterialApp(
        //     title: 'Nova Task',
        //     theme: ThemeData(
        //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //       useMaterial3: true,
        //     ),
        //     debugShowCheckedModeBanner: false,
        //     home: isLoggedIn ? const MyHomePage() : const LoginScreen(),
        //   ),
        // );
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int currentPageIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 245, 245, 245),
//       bottomNavigationBar: NavigationBar(
//         destinations: [
//           NavigationDestination(
//             icon: Icon(Icons.home, size: 20.sp),
//             label: 'Home',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.task, size: 20.sp),
//             label: 'Tasks',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.category, size: 20.sp),
//             label: 'Categories',
//           ),
//         ],
//         selectedIndex: currentPageIndex,
//         onDestinationSelected: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//       ),
//       body: SafeArea(
//         child: [
//           HomeScreen(),
//           TasksScreen(),
//           const CategoriesScreen(),
//         ][currentPageIndex],
//       ),
//     );
//   }
// }
