import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // ЗАГОЛОВОК ПРИЛОЖЕНИЯ
        appBar: AppBar(
          title: const Text('Видеокарты'),
          backgroundColor: Colors.blueGrey[800],
        ),
        body: const VideoCardInfo(),
      ),
    );
  }
}

class VideoCardInfo extends StatelessWidget {
  const VideoCardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Название ПО
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Center(
              child: Text(
                'Видеокарта',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Описание ПО
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Text(
              'Видеокарта — это устройство, которое отвечает за обработку и вывод графики на экран компьютера.Она преобразует цифровые данные в визуальные изображения.Видеокарты бывают встроенными (интегрированными) и дискретными (отдельными).',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),

          // Блок с картинкой и списком
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Картинка
              Container(
                width: 130,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images.jpeg',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Список
              Expanded(
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('1. Дискретные', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 4),
                      Text('2. Интегрированные', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 4),
                      Text('3. Игровые', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 4),
                      Text('4. Профессиональные', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ФИО номер группы
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Row(
              children: [
                Icon(Icons.person_outline, size: 40),
                SizedBox(width: 16),
                Text(
                  'Рудаков Т.И.',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}