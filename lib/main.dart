import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/task_viewmodel.dart';
import 'views/task_screen.dart';

void main() {
  runApp(const TasklyApp());
}

class TasklyApp extends StatelessWidget {
  const TasklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
      ],
      child: MaterialApp(
        title: 'Taskly',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: const Color(0xFFF9F9F9),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.indigo,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const TaskScreen(),
      ),
    );
  }
}


