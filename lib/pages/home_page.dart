import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/pages/profile_page.dart';
import 'package:flutter2/routes.dart';
import 'dart:io';

// Модель данных для видеокарты
class VideoCard {
  final String name;
  final String description;
  final String imageUrl;

  const VideoCard({required this.name, required this.description, required this.imageUrl});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MainContent(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ИНФОРМАЦИЯ О ВИДЕОКАРТАХ'),
        automaticallyImplyLeading: false,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  // --- КЛЮЧЕВОЙ МОМЕНТ: Заменены ссылки-заглушки на реальные изображения ---
  final List<VideoCard> videoCards = const [
    VideoCard(
        name: 'GeForce RTX 4090',
        description: 'Флагманская модель от NVIDIA для 4K-гейминга и профессиональных задач.',
        imageUrl: 'https://www.nvidia.com/content/dam/en-zz/Solutions/geforce/ada/rtx-4090/geforce-rtx-4090-web-partner-card-307-d.jpg'),
    VideoCard(
        name: 'Radeon RX 7900 XTX',
        description: 'Топовое решение от AMD, построенное на архитектуре RDNA 3.',
        imageUrl: 'https://www.amd.com/system/files/2022-11/1723521-amd-radeon-rx-7900-series-angle-1260x709.png'),
    VideoCard(
        name: 'GeForce RTX 4070',
        description: 'Сбалансированная карта для 2K-гейминга с поддержкой DLSS 3.',
        imageUrl: 'https://i0.wp.com/www.overclockers.com/wp-content/uploads/2022/11/card3-scaled.jpg?ssl=1'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktopOrWeb = kIsWeb || Platform.isMacOS || Platform.isLinux || Platform.isWindows;
    final verticalPadding = isDesktopOrWeb ? 24.0 : 8.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: Text('Видеокарты', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          const SizedBox(height: 8),
          const Center(child: Text('Устройства для обработки и вывода графики.', textAlign: TextAlign.center)),
          SizedBox(height: verticalPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // --- КЛЮЧЕВОЙ МОМЕНТ: Здесь также заменены ссылки на реальные изображения ---
              Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network('https://www.nvidia.com/content/dam/en-zz/Solutions/geforce/ada/rtx-4080/geforce-rtx-4080-16gb-web-partner-card-307-d.jpg', fit: BoxFit.cover))),
              const SizedBox(width: 16),
              Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network('https://www.amd.com/system/files/2023-05/1935322-amd-radeon-rx-7600-angle-1260x709_0.png', fit: BoxFit.cover))),
            ],
          ),
          SizedBox(height: verticalPadding),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // GridView для широких экранов
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 4,
                  ),
                  itemCount: videoCards.length,
                  itemBuilder: (context, index) => VideoCardTile(card: videoCards[index]),
                );
              } else {
                // ListView для узких экранов
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: videoCards.length,
                  itemBuilder: (context, index) => VideoCardTile(card: videoCards[index]),
                );
              }
            },
          ),
          SizedBox(height: verticalPadding),
          const Divider(),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_pin_circle_outlined),
              SizedBox(width: 8),
              Text('Рудаков Тимофей Иванович', style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}

class VideoCardTile extends StatelessWidget {
  final VideoCard card;
  const VideoCardTile({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(card.name),
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.detail, arguments: card);
        },
      ),
    );
  }
}