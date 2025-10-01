// lib/pages/register_page.dart
import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import 'login_page.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Регистрация успешна!')),
      );
      // Можно перейти на профиль или логин
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
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
                passwordController: _passwordController, // Передаём ссылку на основной пароль
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Зарегистрироваться'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // назад к логину
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

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RegisterPage(),
  ));
}