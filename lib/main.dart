// lib/main.dart
import 'package:flutter/material.dart';
// --- КЛЮЧЕВОЙ МОМЕНТ: Импортируем все страницы и файл с маршрутами ---
// Это позволяет ссылаться на виджеты страниц и константы маршрутов в одном месте.
import 'package:flutter2/pages/detail_page.dart';
import 'package:flutter2/pages/home_page.dart';
import 'package:flutter2/pages/loading_page.dart';
import 'package:flutter2/pages/login_page.dart';
import 'package:flutter2/pages/register_page.dart';
import 'package:flutter2/routes.dart'; // Импорт констант для маршрутов

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practical Work 6',

      // --- КЛЮЧЕВОЙ МОМЕНТ: Установка начального маршрута ---
      // Свойство `initialRoute` указывает Flutter, какой экран загружать при запуске.
      // Мы используем константу из нашего класса `AppRoutes`, чтобы избежать ошибок.
      initialRoute: AppRoutes.loading,

      // --- КЛЮЧЕВОЙ МОМЕНТ: Определение карты маршрутов ---
      // Свойство `routes` - это карта (Map), где ключами являются строковые имена маршрутов,
      // а значениями - функции, которые создают соответствующий виджет экрана.
      // Такой подход называется "именованная навигация".
      routes: {
        AppRoutes.loading: (context) => const LoadingPage(),
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.register: (context) => const RegisterPage(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.detail: (context) => const DetailPage(),
      },
    );
  }
}