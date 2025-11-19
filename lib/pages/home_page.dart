import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Импорт bloc
import 'package:flutter2/models/video_card.dart';
import 'package:flutter2/pages/profile_page.dart';
import 'package:flutter2/routes.dart';
import 'package:flutter2/pages/home/bloc/home_bloc.dart'; // Импорт нашего блока

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Список страниц. Обратите внимание: MainContent теперь не константа,
  // так как мы будем оборачивать его провайдером выше или использовать здесь.
  // Но так как BlocProvider мы внедрим в main.dart (в роутинге), здесь просто вызываем виджет.
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
        // Добавим кнопку обновления для проверки работы BLoC
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                // Отправляем событие загрузки повторно
                context.read<HomeBloc>().add(LoadVideoCardsEvent());
              },
            )
        ],
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

  @override
  Widget build(BuildContext context) {
    final isDesktopOrWeb = kIsWeb || Platform.isMacOS || Platform.isLinux || Platform.isWindows;
    final verticalPadding = isDesktopOrWeb ? 24.0 : 8.0;

    // Используем BlocBuilder для перестройки UI на основе состояния
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        // 1. Состояние Загрузки
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Состояние Ошибки
        if (state is HomeError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60, color: Colors.red),
                const SizedBox(height: 16),
                Text(state.message, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(LoadVideoCardsEvent());
                    },
                    child: const Text("Повторить")
                )
              ],
            ),
          );
        }

        // 3. Состояние Загружено (показываем контент)
        if (state is HomeLoaded) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: Text('Видеокарты', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                const SizedBox(height: 8),
                const Center(child: Text('Устройства для обработки и вывода графики.', textAlign: TextAlign.center)),
                SizedBox(height: verticalPadding),

                // Статический блок с картинками (оставил как в оригинале для красоты)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network('https://www.nvidia.com/content/dam/en-zz/Solutions/geforce/ada/rtx-4080/geforce-rtx-4080-16gb-web-partner-card-307-d.jpg', fit: BoxFit.cover, errorBuilder: (c,o,s) => const Icon(Icons.image_not_supported)))),
                    const SizedBox(width: 16),
                    Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network('https://www.amd.com/system/files/2023-05/1935322-amd-radeon-rx-7600-angle-1260x709_0.png', fit: BoxFit.cover, errorBuilder: (c,o,s) => const Icon(Icons.image_not_supported)))),
                  ],
                ),
                SizedBox(height: verticalPadding),

                // Список видеокарт из BLoC
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 600) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 4,
                        ),
                        itemCount: state.videoCards.length,
                        itemBuilder: (context, index) => VideoCardTile(card: state.videoCards[index]),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.videoCards.length,
                        itemBuilder: (context, index) => VideoCardTile(card: state.videoCards[index]),
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

        // 4. Начальное состояние (или если что-то пошло не так)
        return const Center(child: Text("Нажмите обновить для загрузки"));
      },
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
        leading: SizedBox(
          width: 60,
          height: 60,
          child: Image.network(card.imageUrl, fit: BoxFit.cover, errorBuilder: (c, o, s) => const Icon(Icons.broken_image)),
        ),
        title: Text(card.name),
        subtitle: Text(card.description, maxLines: 1, overflow: TextOverflow.ellipsis),
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.detail, arguments: card);
        },
      ),
    );
  }
}