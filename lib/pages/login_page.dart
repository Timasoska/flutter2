// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
// --- КЛЮЧЕВОЙ МОМЕНТ: Импортируем наш файл с маршрутами ---
import '../routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // --- КЛЮЧЕВОЙ МОМЕНТ: Навигация после успешной авторизации ---
      // Используем `pushReplacementNamed` для перехода на главный экран.
      // "Replacement" означает, что текущий экран (LoginPage) будет удален из стека навигации.
      // В результате пользователь не сможет нажать системную кнопку "назад", чтобы вернуться на экран входа.
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Экран авторизации')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                inputType: InputFieldType.email,
                labelText: 'Email',
                hintText: 'example@mail.com',
                prefixIcon: Icons.email,
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                inputType: InputFieldType.password,
                labelText: 'Пароль',
                hintText: 'Минимум 6 символов',
                prefixIcon: Icons.lock,
                controller: _passwordController,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Войти'),
              ),
              TextButton(
                onPressed: () {
                  // --- КЛЮЧЕВОЙ МОМЕНТ: Навигация на экран регистрации ---
                  // Используем `pushNamed`, чтобы просто открыть экран регистрации поверх текущего.
                  // Пользователь сможет вернуться на этот экран, нажав кнопку "назад".
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                child: const Text('Нет аккаунта? Зарегистрируйтесь'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}