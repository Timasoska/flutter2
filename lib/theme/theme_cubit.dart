import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class ThemeCubit extends Cubit<ThemeMode> {
  // Начальное состояние - светлая тема
  ThemeCubit() : super(ThemeMode.light);

  /// Переключить тему
  void toggleTheme(bool isDark) {
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}