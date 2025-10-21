import 'package:flutter/material.dart';
import 'package:flutter2/pages/detail_page.dart';
import 'package:flutter2/pages/home_page.dart';
import 'package:flutter2/pages/loading_page.dart';
import 'package:flutter2/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Видеокарты',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightGreen,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      initialRoute: AppRoutes.loading,
      routes: {
        AppRoutes.loading: (context) => const LoadingPage(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.detail: (context) => const DetailPage(),
      },
    );
  }
}