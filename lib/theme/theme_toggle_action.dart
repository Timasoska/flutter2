import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_cubit.dart';

class ThemeToggleAction extends StatelessWidget {
  const ThemeToggleAction({super.key});

  @override
  Widget build(BuildContext context) {
    // Слушаем изменения темы
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark;

    return IconButton(
      tooltip: isDark ? 'Включить светлую тему' : 'Включить тёмную тему',
      icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
      onPressed: () {
        // Вызываем метод Cubit для смены темы
        context.read<ThemeCubit>().toggleTheme(!isDark);
      },
    );
  }
}