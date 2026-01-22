import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final forums = [
      _Thread(
        title: 'Новости и релизы',
        preview: 'Обсуждаем свежие статьи, книги и экранизации.',
        unread: 12,
        time: 'Сегодня',
      ),
      _Thread(
        title: 'Квизы и челленджи',
        preview: 'Новые тесты и рейтинги участников.',
        unread: 5,
        time: 'Сегодня',
      ),
      _Thread(
        title: 'Обсуждения лора',
        preview: 'Вопросы по миру, теориям и фактам.',
        unread: 3,
        time: 'Вчера',
      ),
      _Thread(
        title: 'Рекомендации книг и статей',
        preview: 'Подборки материалов и заметок.',
        unread: 0,
        time: 'Вчера',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        title: const Text('Сообщество'),
        backgroundColor: Colors.black.withOpacity(0.6),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment, color: AppColors.parchment),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: forums.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = forums[index];
          return _ThreadTile(item: item, textTheme: textTheme);
        },
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }
}

class _Thread {
  _Thread({
    required this.title,
    required this.preview,
    required this.unread,
    required this.time,
  });

  final String title;
  final String preview;
  final int unread;
  final String time;
}

class _ThreadTile extends StatelessWidget {
  const _ThreadTile({required this.item, required this.textTheme});

  final _Thread item;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.burgundy.withOpacity(0.8),
              child: Text(
                item.title.isNotEmpty ? item.title[0] : '?',
                style: textTheme.titleMedium?.copyWith(color: AppColors.parchment),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: textTheme.titleMedium
                        ?.copyWith(color: AppColors.parchment),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.preview,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.parchment.withOpacity(0.75),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.time,
                  style: textTheme.bodySmall
                      ?.copyWith(color: AppColors.parchment.withOpacity(0.7)),
                ),
                if (item.unread > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      item.unread.toString(),
                      style:
                          textTheme.bodySmall?.copyWith(color: Colors.black87),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
