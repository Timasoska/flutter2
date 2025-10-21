// lib/pages/detail_page.dart
import 'package:flutter/material.dart';
import 'home_page.dart'; // Импортируем для доступа к модели ListItem

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем аргументы, переданные при навигации
    final item = ModalRoute.of(context)!.settings.arguments as ListItem;

    return Scaffold(
      appBar: AppBar(
        title: Text("Детализация"), // AppBar автоматически получает стрелку "назад"
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                item.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 30),
              Icon(item.icon, size: 120, color: Colors.blueAccent),
              const SizedBox(height: 30),
              Text(
                'Подробное описание:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                item.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}