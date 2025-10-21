import 'package:flutter/material.dart';
import 'home_page.dart'; // для доступа к классу VideoCard

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                // --- КЛЮЧЕВОЙ МОМЕНТ: Убрали .replaceAll(), так как теперь используем прямые ссылки ---
                child: Image.network(card.imageUrl),
              ),
              const SizedBox(height: 24),
              Text(
                'Описание пункта "${card.name}"',
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