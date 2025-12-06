import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter2/data/app_database.dart';
import 'package:flutter2/pages/profile_page.dart';
import 'package:flutter2/routes.dart';
import 'package:flutter2/pages/home/bloc/home_bloc.dart';
import 'package:flutter2/theme/theme_toggle_action.dart'; // Добавить импорт

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Мы убрали const, так как MainContent теперь требует контекста для FAB
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
        actions: [
          // Добавляем кнопку переключения темы
          const ThemeToggleAction(),

          if (_selectedIndex == 0)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<HomeBloc>().add(LoadVideoCardsEvent());
              },
            )
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      // Кнопка добавления (видна только на вкладке Главная)
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        onPressed: () => _showEditDialog(context, null),
        child: const Icon(Icons.add),
      )
          : null,
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

  // Функция для показа диалога (Добавление или Редактирование)
  void _showEditDialog(BuildContext context, VideoCard? card) {
    final isEditing = card != null;
    final nameController = TextEditingController(text: card?.name ?? '');
    final descController = TextEditingController(text: card?.description ?? '');
    final urlController = TextEditingController(text: card?.imageUrl ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isEditing ? 'Редактировать' : 'Добавить карту'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Название')),
              TextField(controller: descController, decoration: const InputDecoration(labelText: 'Описание')),
              TextField(controller: urlController, decoration: const InputDecoration(labelText: 'Ссылка на фото')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = nameController.text;
              final newDesc = descController.text;
              final newUrl = urlController.text;

              if (newName.isNotEmpty) {
                if (isEditing) {
                  // UPDATE: Создаем объект с тем же ID, но новыми данными
                  final updatedCard = VideoCard(
                    id: card.id,
                    name: newName,
                    description: newDesc,
                    imageUrl: newUrl,
                  );
                  context.read<HomeBloc>().add(UpdateVideoCardEvent(updatedCard));
                } else {
                  // CREATE: Создаем объект (ID=0, репозиторий его проигнорирует)
                  final newCard = VideoCard(
                    id: 0,
                    name: newName,
                    description: newDesc,
                    imageUrl: newUrl,
                  );
                  context.read<HomeBloc>().add(AddVideoCardEvent(newCard));
                }
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Сохранить'),
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

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeError) {
          return Center(child: Text(state.message));
        }

        if (state is HomeLoaded) {
          if (state.videoCards.isEmpty) {
            return const Center(child: Text("Список пуст. Добавьте карту!"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: Text('Видеокарты', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                SizedBox(height: verticalPadding),

                // Список карточек
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.videoCards.length,
                  itemBuilder: (context, index) => VideoCardTile(
                    card: state.videoCards[index],
                    // Передаем функции редактирования и удаления
                    onEdit: () => _openEditDialog(context, state.videoCards[index]),
                    onDelete: () => context.read<HomeBloc>().add(DeleteVideoCardEvent(state.videoCards[index].id)),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  // Вспомогательный метод для вызова диалога из MainContent (копипаст логики из State)
  // В идеале диалог лучше вынести в отдельный виджет
  void _openEditDialog(BuildContext context, VideoCard card) {
    // Находим State родителя и вызываем метод
    final homeState = context.findAncestorStateOfType<_HomePageState>();
    homeState?._showEditDialog(context, card);
  }
}

class VideoCardTile extends StatelessWidget {
  final VideoCard card;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const VideoCardTile({
    super.key,
    required this.card,
    required this.onEdit,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: SizedBox(
          width: 60,
          height: 60,
          child: Image.network(card.imageUrl, fit: BoxFit.cover, errorBuilder: (c, o, s) => const Icon(Icons.broken_image)),
        ),
        title: Text(card.name),
        subtitle: Text(card.description, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: onEdit),
            IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: onDelete),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.detail, arguments: card);
        },
      ),
    );
  }
}