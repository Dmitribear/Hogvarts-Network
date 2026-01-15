import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final items = [
      _News('Фестиваль в Хогсмиде', '21 апреля 2024',
          'Тёплый вечер, музыка и сливочное пиво у Три Метлы.'),
      _News('Новые зелеварные рецепты', '18 апреля 2024',
          'Профессор Слизнорт делится улучшенной формулой Животворящего.'),
      _News('Турнир по квиддичу', '15 апреля 2024',
          'Гриффиндор vs Слизерин — решающий матч сезона.'),
    ];

    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        title: const Text('Новости'),
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
                    Icon(Icons.newspaper, color: AppColors.gold.withOpacity(0.9)),
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
    );
  }
}

class _News {
  _News(this.title, this.date, this.body);

  final String title;
  final String date;
  final String body;
}
