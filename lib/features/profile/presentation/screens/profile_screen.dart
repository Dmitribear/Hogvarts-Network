import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/fan_profile.dart';
import '../providers/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(fanProfileProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль фаната'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: profileState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Ошибка: $error')),
          data: (profile) {
            final data = profile ??
                const FanProfile(
                  name: 'Анонимный маг',
                  house: 'Не распределён',
                  patronus: 'Неизвестен',
                  wand: 'Неизвестная палочка',
                  avatarUrl: '',
                );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: AppColors.gold.withOpacity(0.2),
                      backgroundImage:
                          data.avatarUrl.isNotEmpty ? NetworkImage(data.avatarUrl) : null,
                      child: data.avatarUrl.isEmpty
                          ? Icon(Icons.person, color: AppColors.gold.withOpacity(0.8))
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.name, style: textTheme.titleLarge),
                          const SizedBox(height: 4),
                          Text('Факультет: ${data.house}',
                              style: textTheme.bodyMedium?.copyWith(color: AppColors.gold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _InfoTile(
                  title: 'Патронус',
                  value: data.patronus,
                  icon: Icons.auto_awesome,
                ),
                _InfoTile(
                  title: 'Палочка',
                  value: data.wand,
                  icon: Icons.bolt,
                ),
                const SizedBox(height: 12),
                Text('Достижения', style: textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: (data.achievements.isEmpty
                          ? ['Пока нет достижений']
                          : data.achievements)
                      .map(
                    (ach) => Chip(
                      label: Text(ach),
                      backgroundColor: Colors.white.withOpacity(0.06),
                    ),
                  ).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.labelLarge),
                Text(
                  value,
                  style: textTheme.bodyLarge?.copyWith(color: AppColors.parchment),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
