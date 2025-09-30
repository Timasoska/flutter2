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
        appBar: AppBar(
          title: const Text('Видеокарты'),
          backgroundColor: Colors.blueGrey[800],
        ),
        body: const VideoCardInfo(),
      ),
    );
  }
}

class VideoCardInfo extends StatefulWidget {
  const VideoCardInfo({super.key});

  @override
  State<VideoCardInfo> createState() => _VideoCardInfoState();
}

class _VideoCardInfoState extends State<VideoCardInfo> {
  // Список URL-адресов для изображений, загружаемых по сети.
  final List<String> imageUrls = [
    'https://picsum.photos/id/1/400/300',
    'https://picsum.photos/id/48/400/300',
    'https://picsum.photos/id/171/400/300',
    'https://picsum.photos/id/219/400/300',
    'https://picsum.photos/id/56/400/300',
    'https://picsum.photos/id/119/400/300',
  ];

  // Данные для вертикального списка карточек.
  final List<Map<String, String>> videoCardTypes = [
    {
      'title': 'Игровая видеокарта',
      'subtitle': 'Специально разработана для максимальной производительности в играх.',
    },
    {
      'title': 'Профессиональная видеокарта',
      'subtitle': 'Предназначена для использования в области компьютерной графики и дизайна.',
    },
    {
      'title': 'Интегрированная видеокарта',
      'subtitle': 'Встроена в материнскую плату, используется в офисных компьютерах.',
    },
    {
      'title': 'Дискретная видеокарта',
      'subtitle': 'Отдельная карта, устанавливаемая в слот расширения.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Основная информация о ПО ---
          const Center(
            child: Text(
              'Видеокарта',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Видеокарта — это устройство, которое отвечает за обработку и вывод графики на экран компьютера. Она преобразует цифровые данные в визуальные изображения.',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          // --- ЗАДАНИЕ 1: Горизонтальный ListView с изображениями по сети ---
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Card(
                  // Свойство для обрезки содержимого (Image) по форме Card
                  clipBehavior: Clip.antiAlias,
                  // Задаем форму Card со скругленными углами
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  // Используем Image.network для загрузки картинки по URL
                  child: Image.network(
                    imageUrls[index],
                    width: 180,
                    fit: BoxFit.cover,
                    // Показываем индикатор загрузки, пока картинка грузится
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    // Показываем иконку ошибки, если загрузка не удалась
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.broken_image, size: 48));
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // --- ЗАДАНИЕ 2: Вертикальный ListView в форме карточек (Card) ---
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: videoCardTypes.length,
            itemBuilder: (context, index) {
              final cardData = videoCardTypes[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  // Иконка перед текстом
                  leading: const Icon(Icons.developer_board, color: Colors.blueGrey),
                  title: Text(cardData['title']!),
                  subtitle: Text(cardData['subtitle']!),
                  // Иконка после текста
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),

                  // --- ЗАДАНИЕ 3: Вывод SnackBar при нажатии на карточку ---
                  onTap: () {
                    // Скрываем предыдущий SnackBar, если он еще виден
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    // Показываем новый SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Выбран тип: ${cardData['title']}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // --- Блок ФИО ---
          Card(
            color: Colors.blueGrey[50],
            child: const ListTile(
              leading: Icon(Icons.person_outline, size: 40),
              title: Text(
                'Рудаков Тимофей Иванович',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'ИКБО-26-22',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}