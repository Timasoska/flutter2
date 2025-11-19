import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Импорт
import 'package:flutter2/pages/home/bloc/home_bloc.dart'; // Импорт блока
import 'package:flutter2/pages/loading_page.dart';
import 'package:flutter2/pages/login_page.dart';
import 'package:flutter2/pages/register_page.dart';
import 'package:flutter2/pages/home_page.dart';
import 'package:flutter2/pages/detail_page.dart';
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
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.register: (context) => const RegisterPage(),

        // ВНЕДРЕНИЕ BLoC ЗДЕСЬ:
        // Используем каскадный оператор (..), чтобы сразу добавить событие при создании блока
        AppRoutes.home: (context) => BlocProvider(
          create: (context) => HomeBloc()..add(LoadVideoCardsEvent()),
          child: const HomePage(),
        ),

        AppRoutes.detail: (context) => const DetailPage(),
      },
    );
  }
}