// lib/pages/profile_page.dart
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _fullName = 'Рудаков Тимофей Иванович';
  String _group = 'ИКБО-26-22';
  String _password = '••••••••'; // маскировка пароля

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController.text = _fullName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _fullName = _nameController.text;
        if (_passwordController.text.isNotEmpty) {
          _password = '••••••••'; // обновляем маску
        }
      });
      // Здесь можно сохранить данные в SharedPreferences, API и т.д.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Данные успешно обновлены!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Center(
                child: Icon(Icons.person, size: 80, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Отображение текущего имени
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Полное имя',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Имя не может быть пустым';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Группа (только для отображения)
              TextFormField(
                initialValue: _group,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'Группа',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Поле для нового пароля (опционально)
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Новый пароль (оставьте пустым, чтобы не менять)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 6) {
                    return 'Пароль должен быть не короче 6 символов';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Кнопка сохранения
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Сохранить изменения'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}