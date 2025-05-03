import 'package:flutter/material.dart';

class AppealListScreen extends StatelessWidget {
  const AppealListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appeals')),
      body: const Center(child: Text('Appeal List Screen')),
    );
  }
}