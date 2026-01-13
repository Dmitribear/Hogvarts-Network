import 'package:flutter/material.dart';

class HogwartsMapScreen extends StatelessWidget {
  const HogwartsMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Карта Хогвартса')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 64, color: Colors.white.withOpacity(0.6)),
            const SizedBox(height: 12),
            Text(
              'Интерактивная карта скоро появится',
              style: textTheme.titleMedium,
            ),
            Text(
              'SVG/CustomPainter + кликабельные зоны',
              style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
