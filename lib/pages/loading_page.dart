// lib/pages/loading_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter2/routes.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Переход на экран авторизации через 4 секунды с заменой
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_top, size: 60, color: Colors.blue),
            SizedBox(height: 20),
            Text('Экран заставки', style: TextStyle(fontSize: 22)),
            SizedBox(height: 10),
            Text(
              'Автоматический переход через 4 секунды...',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}