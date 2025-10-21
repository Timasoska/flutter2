// lib/pages/home_page.dart
import 'package:flutter/foundation.dart'; // для kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter2/pages/profile_page.dart';
import 'package:flutter2/routes.dart';
import 'dart:io'; // для Platform

// Модель данных для элемента списка
class ListItem {
  final String title;
  final String description;
  final IconData icon;

  const ListItem({required this.title, required this.description, required this.icon});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Определяем экраны для NavigationBar
  static final List<Widget> _widgetOptions = <Widget>[
    const MainContent(), // Наш основной контент с адаптивным дизайном
    const ProfilePage(), // Экран профиля
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Основной экран' : 'Профиль'),
        automaticallyImplyLeading: false, // Убираем стрелку "назад"
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
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

// Виджет для основного контента с адаптивностью
class MainContent extends StatelessWidget {
  const MainContent({super.key});

  // Создаем тестовые данные
  final List<ListItem> items = const [
    ListItem(title: 'Пункт 1', description: 'Описание для пункта 1', icon: Icons.looks_one),
    ListItem(title: 'Пункт 2', description: 'Описание для пункта 2', icon: Icons.looks_two),
    ListItem(title: 'Пункт 3', description: 'Описание для пункта 3', icon: Icons.looks_3),
    ListItem(title: 'Пункт 4', description: 'Описание для пункта 4', icon: Icons.looks_4),
    ListItem(title: 'Пункт 5', description: 'Описание для пункта 5', icon: Icons.looks_5),
    ListItem(title: 'Пункт 6', description: 'Описание для пункта 6', icon: Icons.looks_6),
  ];

  @override
  Widget build(BuildContext context) {
    // Адаптивный отступ для десктоп/веб
    final isDesktopOrWeb = kIsWeb || Platform.isMacOS || Platform.isLinux || Platform.isWindows;
    final verticalPadding = isDesktopOrWeb ? 40.0 : 8.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Вывод в 2 столбца, если ширина больше 600
        if (constraints.maxWidth > 600) {
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: verticalPadding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 3.5 / 1, // Соотношение сторон карточки
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ItemCard(item: items[index]);
            },
          );
        } else {
          // Вывод в 1 столбец (список)
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: verticalPadding),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ItemCard(item: items[index]);
            },
          );
        }
      },
    );
  }
}

// Карточка элемента для списка/сетки
class ItemCard extends StatelessWidget {
  final ListItem item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(item.icon, size: 40, color: Colors.blueAccent),
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item.description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Переход на экран детализации с передачей объекта
          Navigator.pushNamed(context, AppRoutes.detail, arguments: item);
        },
      ),
    );
  }
}