import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final threads = [
      _Thread(
        title: 'Минерва МакГонагалл',
        preview: 'Проверь новое расписание занятий.',
        unread: 2,
        time: '10:12',
      ),
      _Thread(
        title: 'Клуб Зельеварения',
        preview: 'Рецепт снадобья обновлён.',
        unread: 0,
        time: '09:41',
      ),
      _Thread(
        title: 'Дамблдор',
        preview: 'Нужно обсудить турнир по квиддичу.',
        unread: 1,
        time: 'Вчера',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        title: const Text('Сообщения'),
        backgroundColor: Colors.black.withOpacity(0.6),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.parchment),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: threads.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = threads[index];
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
                    maxLines: 1,
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
