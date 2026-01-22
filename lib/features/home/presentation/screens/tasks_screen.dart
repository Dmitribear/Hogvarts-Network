import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final content = [
      _ContentItem('Книга: Философский камень', 'Роман, 320 стр.', 'Книга',
          progress: 0.3),
      _ContentItem('Статья: История Хогвартса', 'Обзор основателей', 'Статья',
          progress: 0.6),
      _ContentItem('Видео: Интервью с актёрами', '10 минут, YouTube', 'Видео',
          progress: 0.0),
      _ContentItem('Подборка: Лучшие теории', 'Фан-обсуждения и факты',
          'Подборка',
          progress: 0.8),
      _ContentItem('Квиз: Проверь знания', '10 вопросов по лору', 'Квиз',
          progress: 0.2),
    ];
    final filters = ['Все', 'Книги', 'Статьи', 'Видео', 'Подборки', 'Квизы'];
    String activeFilter = 'Все';

    return StatefulBuilder(
      builder: (context, setState) {
        final filtered = activeFilter == 'Все'
            ? content
            : content.where((c) => c.type == activeFilter).toList();
        return Scaffold(
          backgroundColor: AppColors.navy,
          appBar: AppBar(
            title: const Text('Библиотека'),
            backgroundColor: Colors.black.withOpacity(0.6),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: filters
                      .map(
                        (f) => ChoiceChip(
                          label: Text(f),
                          selected: activeFilter == f,
                          onSelected: (_) => setState(() => activeFilter = f),
                          selectedColor: AppColors.gold.withOpacity(0.2),
                          backgroundColor: Colors.white.withOpacity(0.05),
                          labelStyle: textTheme.bodySmall?.copyWith(
                            color: AppColors.parchment,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                ...filtered
                    .map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _ContentCard(item: item, textTheme: textTheme),
                        ))
                    .toList(),
              ],
            ),
          ),
          bottomNavigationBar: const AppBottomNav(currentIndex: 1),
        );
      },
    );
  }
}

class _ContentItem {
  _ContentItem(this.title, this.subtitle, this.type, {required this.progress});

  final String title;
  final String subtitle;
  final String type;
  final double progress;
}

class _ContentCard extends StatelessWidget {
  const _ContentCard({required this.item, required this.textTheme});

  final _ContentItem item;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.burgundy.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item.type,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.parchment,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.open_in_new, color: AppColors.gold),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            item.title,
            style: textTheme.titleMedium?.copyWith(color: AppColors.parchment),
          ),
          const SizedBox(height: 6),
          Text(
            item.subtitle,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.parchment.withOpacity(0.75),
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: item.progress,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.08),
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.gold.withOpacity(0.9)),
            ),
          ),
        ],
      ),
    );
  }
}
