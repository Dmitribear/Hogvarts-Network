import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final threads = [
      _Thread('Лучшая защита от дементоров?', 'Патронус или шоколад после встречи?',
          'Проф. Люпин', 42),
      _Thread('Любимые шутки из магазинов Уизли',
          'Что посоветуете новичку? Хотим устроить розыгрыш.', 'Джордж', 15),
      _Thread('Тонкие нюансы Оборотного зелья',
          'Вопрос о времени действия и побочках.', 'Гермиона', 23),
    ];

    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        title: const Text('Форум'),
        backgroundColor: Colors.black.withOpacity(0.6),
        actions: [
          IconButton(
            icon: const Icon(Icons.create_outlined, color: AppColors.parchment),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: threads.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final t = threads[index];
          return Container(
            padding: const EdgeInsets.all(12),
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
                    Icon(Icons.forum_outlined, color: AppColors.gold.withOpacity(0.9)),
                    const SizedBox(width: 8),
                    Text(
                      t.author,
                      style: textTheme.bodySmall
                          ?.copyWith(color: AppColors.parchment.withOpacity(0.7)),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.chat_bubble_outline,
                            size: 16, color: AppColors.parchment),
                        const SizedBox(width: 4),
                        Text(
                          t.replies.toString(),
                          style: textTheme.bodySmall
                              ?.copyWith(color: AppColors.parchment),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  t.title,
                  style: textTheme.titleMedium
                      ?.copyWith(color: AppColors.parchment, letterSpacing: 0.2),
                ),
                const SizedBox(height: 6),
                Text(
                  t.preview,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: AppColors.parchment.withOpacity(0.8)),
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

class _Thread {
  _Thread(this.title, this.preview, this.author, this.replies);

  final String title;
  final String preview;
  final String author;
  final int replies;
}
