import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final items = [
      _News('Подборка: книги и лор', 'Свежие главы, статьи и материалы.',
          'Апрель 2024'),
      _News('Гид: как искать персонажей', 'Фильтры по домам, ролям, сезонам.',
          'Апрель 2024'),
      _News('Квизы: новая коллекция', 'Самопроверка по лору и фильмам.',
          'Март 2024'),
    ];

    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        title: const Text('Книги и лор'),
        backgroundColor: Colors.black.withOpacity(0.6),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.menu_book, color: AppColors.gold.withOpacity(0.9)),
                    const SizedBox(width: 8),
                    Text(
                      item.date,
                      style: textTheme.bodySmall
                          ?.copyWith(color: AppColors.parchment.withOpacity(0.7)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  style: textTheme.titleMedium
                      ?.copyWith(color: AppColors.parchment, letterSpacing: 0.2),
                ),
                const SizedBox(height: 6),
                Text(
                  item.body,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: AppColors.parchment.withOpacity(0.85)),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _News {
  _News(this.title, this.body, this.date);

  final String title;
  final String body;
  final String date;
}
