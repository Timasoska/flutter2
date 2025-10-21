// lib/widgets/text_field.dart
import 'package:flutter/material.dart';

// Определяем типы полей для гибкой валидации
enum InputFieldType {
  fullName,
  email,
  password,
  confirmPassword,
}

// Кастомный TextFormField — универсальный компонент для всех форм
class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String labelText;
  final String? hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final TextEditingController? passwordController; // для confirmPassword

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.labelText,
    this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.passwordController,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _hidePassword = true; // Флаг для скрытия/показа пароля

  String? _validator(String? value) {   // Функция валидации в зависимости от типа поля
    if (value == null || value.isEmpty) {
      return 'Поле не может быть пустым';
    }

    switch (widget.inputType) {
      case InputFieldType.fullName:
        final reg = RegExp(r'^[A-Za-zА-Яа-яёЁ\s]+$'); // Только буквы (латиница и кириллица) и пробелы
        if (!reg.hasMatch(value)) {
          return 'Имя должно содержать только буквы и пробелы';
        }
        break;

      case InputFieldType.email:
        final reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!reg.hasMatch(value)) {
          return 'Некорректный email';
        }
        break;

      case InputFieldType.password:
        final reg = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{6,}$');
        if (!reg.hasMatch(value)) {
          return 'Пароль: минимум 6 символов, буквы и цифры';
        }
        break;

      case InputFieldType.confirmPassword:
        if (value != widget.passwordController?.text) {
          return 'Пароли не совпадают';
        }
        break;
    }

    return null;
  }

  TextInputType get _keyboardType {   // Определяем тип клавиатуры
    switch (widget.inputType) {
      case InputFieldType.email:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  TextInputAction get _textInputAction { // Действие на клавиатуре (Next или Done)
    switch (widget.inputType) {
      case InputFieldType.confirmPassword:
        return TextInputAction.done;
      default:
        return TextInputAction.next;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.inputType == InputFieldType.password ||
        widget.inputType == InputFieldType.confirmPassword;

    return TextFormField(
      controller: widget.controller,
      obscureText: isPassword ? _hidePassword : false,
      keyboardType: _keyboardType,
      textInputAction: _textInputAction,
      onFieldSubmitted: (value) {
        if (widget.inputType != InputFieldType.confirmPassword) {
          FocusScope.of(context).nextFocus();
        }
      },
      validator: _validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: Icon(widget.prefixIcon),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _hidePassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _hidePassword = !_hidePassword;
            });
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}