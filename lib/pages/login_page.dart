// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import 'register_page.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Авторизация успешна!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
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

// Для запуска отдельно
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}