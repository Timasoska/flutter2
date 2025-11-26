import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter2/di/di.dart'; // Импорт настройки DI
import 'package:flutter2/pages/home/bloc/home_bloc.dart';
import 'package:flutter2/pages/loading_page.dart';
import 'package:flutter2/pages/login_page.dart';
import 'package:flutter2/pages/register_page.dart';
import 'package:flutter2/pages/home_page.dart';
import 'package:flutter2/pages/detail_page.dart';
import 'package:flutter2/routes.dart';

void main() {
  // Обязательно для инициализации Drift и PathProvider
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация зависимостей (GetIt)
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Видеокарты (Drift + DI)',
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

        // ВНЕДРЕНИЕ ЗАВИСИМОСТЕЙ:
        // getIt<HomeBloc>() автоматически создаст блок,
        // подставив в него репозиторий, а в репозиторий - базу данных.
        AppRoutes.home: (context) => BlocProvider(
          create: (context) => getIt<HomeBloc>()..add(LoadVideoCardsEvent()),
          child: const HomePage(),
        ),

        AppRoutes.detail: (context) => const DetailPage(),
      },
    );
  }
}