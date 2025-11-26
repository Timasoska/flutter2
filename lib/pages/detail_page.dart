import 'package:flutter/material.dart';
import '../data/app_database.dart'; // Новый импорт модели VideoCard

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Приводим аргументы к типу VideoCard (сгенерированному Drift)
    final card = ModalRoute.of(context)!.settings.arguments as VideoCard;

    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                // card.imageUrl теперь приходит из БД
                child: Image.network(
                  card.imageUrl,
                  errorBuilder: (c, o, s) => const Icon(Icons.broken_image, size: 100),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Описание: ${card.name}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                card.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}