import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Класс MyApp остаётся StatelessWidget, так как он не меняется
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // ЗАГОЛОВОК ПРИЛОЖЕНИЯ с КАСТОМНЫМ ШРИФТОМ
        appBar: AppBar(
          title: const Text(
            'Видеокарты',
            style: TextStyle(
              fontFamily: 'RobotoCustom', // Используем шрифт из pubspec.yaml
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blueGrey[800],
        ),
        body: const VideoCardInfo(), // Теперь это StatefulWidget
      ),
    );
  }
}

// Превращаем VideoCardInfo в StatefulWidget, так как состояние (картинка) будет меняться
class VideoCardInfo extends StatefulWidget {
  const VideoCardInfo({super.key});

  @override
  State<VideoCardInfo> createState() => _VideoCardInfoState();
}

// Класс состояния, где хранится и обновляется индекс текущей картинки
class _VideoCardInfoState extends State<VideoCardInfo> {
  // Переменная состояния: индекс текущего изображения (начинаем с 0)
  int _currentImageIndex = 0;

  // Список путей к 5 изображениям в папке assets/images/
  final List<String> _imagePaths = [
    'assets/images/images1.jpeg',
    'assets/images/images2.jpg',
    'assets/images/images3.jpg',
    'assets/images/images4.png',
    'assets/images/images5.jpg',
  ];

  // Функция для смены изображения на следующее
  void _changeImage() {
    setState(() {
      // Увеличиваем индекс на 1, и если он выходит за пределы списка, возвращаемся к 0
      _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
    });
  }

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
              'Видеокарта — это устройство, которое отвечает за обработку и вывод графики на экран компьютера. Она преобразует цифровые данные в визуальные изображения. Видеокарты бывают встроенными (интегрированными) и дискретными (отдельными).',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),

          // Блок с картинкой и списком
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Картинка, обёрнутая в GestureDetector для обработки нажатий
              GestureDetector(
                onTap: _changeImage, // При нажатии вызываем функцию смены изображения
                child: Container(
                  width: 130,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: Image.asset(
                      _imagePaths[_currentImageIndex], // Берем путь из списка по текущему индексу
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain, // Чтобы изображение не искажалось
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Список (не меняется, поэтому остаётся внутри Column)
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