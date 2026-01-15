import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final featured = _TaskItem(
      title: 'Курс Магии: Базовый уровень',
      subtitle: 'Люмос • Вингардиум Левиоса • Экспекто Патронум',
      progress: 0.72,
      badge: 'Избранное',
      mentor: 'Проф. Флитвик',
      duration: '6 недель',
    );
    final tasks = [
      _TaskItem(
        title: 'Зельеварение: продвинутый уровень',
        subtitle: 'Оборотное, Животворящее, Бульбодоксное',
        progress: 0.35,
        badge: 'Практика',
        mentor: 'Проф. Слизнорт',
        duration: '4 недели',
      ),
      _TaskItem(
        title: 'Боевые чары',
        subtitle: 'Протего • Экспеллиармус • Редукто',
        progress: 0.5,
        badge: 'Дуэли',
        mentor: 'Проф. Люпин',
        duration: '5 недель',
      ),
      _TaskItem(
        title: 'История магии',
        subtitle: 'Основатели Хогвартса, великие битвы',
        progress: 0.9,
        badge: 'Лекции',
        mentor: 'Проф. Бинс',
        duration: '3 недели',
      ),
    ];
    final schedule = [
      ('Практика по Зельям', 'Завтра, 18:00, Подземелья'),
      ('Дуэльный клуб', 'Чт, 19:30, Большой зал'),
      ('Самостоятельная практика чар', 'Пт, 17:00, Аудитория 2B'),
    ];

    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        title: const Text('Задания'),
        backgroundColor: Colors.black.withOpacity(0.6),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FeaturedCard(item: featured, textTheme: textTheme),
            const SizedBox(height: 18),
            Text(
              'Ваши курсы магии',
              style: textTheme.titleLarge?.copyWith(color: AppColors.parchment),
            ),
            const SizedBox(height: 10),
            ...tasks
                .map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _TaskCard(item: item, textTheme: textTheme),
                    ))
                .toList(),
            const SizedBox(height: 10),
            Text(
              'Ближайшие занятия',
              style: textTheme.titleLarge?.copyWith(color: AppColors.parchment),
            ),
            const SizedBox(height: 8),
            ...schedule.map(
              (s) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.schedule, color: AppColors.gold, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.$1,
                            style: textTheme.bodyMedium
                                ?.copyWith(color: AppColors.parchment),
                          ),
                          Text(
                            s.$2,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.parchment.withOpacity(0.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.gold,
        foregroundColor: Colors.black,
        label: const Text('Новый курс'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class _TaskItem {
  _TaskItem({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.badge,
    required this.mentor,
    required this.duration,
  });

  final String title;
  final String subtitle;
  final double progress;
  final String badge;
  final String mentor;
  final String duration;
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.item, required this.textTheme});

  final _TaskItem item;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF3C2A4D), Color(0xFF1E2F3E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                ),
                child: Text(
                  item.badge,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.parchment,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                item.duration,
                style: textTheme.bodySmall
                    ?.copyWith(color: AppColors.parchment.withOpacity(0.8)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            item.title,
            style:
                textTheme.titleLarge?.copyWith(color: AppColors.parchment),
          ),
          const SizedBox(height: 6),
          Text(
            item.subtitle,
            style: textTheme.bodyMedium
                ?.copyWith(color: AppColors.parchment.withOpacity(0.9)),
          ),
          const SizedBox(height: 10),
          Text(
            'Наставник: ${item.mentor}',
            style: textTheme.bodySmall
                ?.copyWith(color: AppColors.parchment.withOpacity(0.8)),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: item.progress,
              minHeight: 10,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.gold.withOpacity(0.95)),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.item, required this.textTheme});

  final _TaskItem item;
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
                  item.badge,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.parchment,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.play_circle_outline, color: AppColors.gold),
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
          const SizedBox(height: 6),
          Text(
            'Наставник: ${item.mentor} • ${item.duration}',
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.parchment.withOpacity(0.7),
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
