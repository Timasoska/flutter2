import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter2/routes.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: const Icon(Icons.developer_board, size: 80),
            ),
            const SizedBox(height: 24),
            const Text(
              'ИНФОРМАЦИЯ О ВИДЕОКАРТАХ',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}