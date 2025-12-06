import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter2/di/di.dart';
import 'package:flutter2/pages/home/bloc/home_bloc.dart';
import 'package:flutter2/pages/loading_page.dart';
import 'package:flutter2/pages/login_page.dart';
import 'package:flutter2/pages/register_page.dart';
import 'package:flutter2/pages/home_page.dart';
import 'package:flutter2/pages/detail_page.dart';
import 'package:flutter2/routes.dart';

// Импорты для темы
import 'package:flutter2/theme/theme_cubit.dart';
import 'package:flutter2/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Получаем ThemeCubit из DI (GetIt)
      create: (_) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Видеокарты (Drift + DI + Theme)',

            // --- Подключение тем ---
            theme: AppTheme.light,       // Светлая тема
            darkTheme: AppTheme.dark,    // Тёмная тема
            themeMode: themeMode,        // Текущий режим (управляется Cubit)
            // ----------------------

            initialRoute: AppRoutes.loading,
            routes: {
              AppRoutes.loading: (context) => const LoadingPage(),
              AppRoutes.login: (context) => const LoginPage(),
              AppRoutes.register: (context) => const RegisterPage(),

              AppRoutes.home: (context) => BlocProvider(
                create: (context) => getIt<HomeBloc>()..add(LoadVideoCardsEvent()),
                child: const HomePage(),
              ),

              AppRoutes.detail: (context) => const DetailPage(),
            },
          );
        },
      ),
    );
  }
}