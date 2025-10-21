// lib/pages/register_page.dart
import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
// --- КЛЮЧЕВОЙ МОМЕНТ: Импортируем наш файл с маршрутами ---
import '../routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // --- КЛЮЧЕВОЙ МОМЕНТ: Навигация после успешной регистрации ---
      // Так же, как и при входе, заменяем стек навигации главным экраном.
      // Это предотвращает возврат на экраны регистрации и входа.
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Экран регистрации')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              CustomTextFormField(
                inputType: InputFieldType.fullName,
                labelText: 'Полное имя',
                hintText: 'Иван Иванов',
                prefixIcon: Icons.person,
                controller: _nameController,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              CustomTextFormField(
                inputType: InputFieldType.confirmPassword,
                labelText: 'Подтверждение пароля',
                hintText: 'Повторите пароль',
                prefixIcon: Icons.lock_clock,
                controller: _confirmPasswordController,
                passwordController: _passwordController,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Зарегистрироваться'),
              ),
              TextButton(
                onPressed: () {
                  // --- КЛЮЧЕВОЙ МОМЕНТ: Возврат на предыдущий экран ---
                  // `Navigator.pop(context)` удаляет текущий экран (RegisterPage) из стека
                  // и показывает предыдущий (в данном случае, LoginPage).
                  Navigator.pop(context);
                },
                child: const Text('Уже есть аккаунт? Войти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}