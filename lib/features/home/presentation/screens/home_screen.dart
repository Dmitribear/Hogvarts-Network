import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hogwarts Network'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroCard(textTheme: textTheme),
            const SizedBox(height: 20),
            Text('Разделы', style: textTheme.titleMedium),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _NavTile(
                    icon: Icons.menu_book,
                    title: 'Библиотека',
                    onTap: () => context.push('/home/library'),
                  ),
                  _NavTile(
                    icon: Icons.map,
                    title: 'Карта Хогвартса',
                    onTap: () => context.push('/home/map'),
                  ),
                  _NavTile(
                    icon: Icons.person,
                    title: 'Профиль',
                    onTap: () => context.push('/home/profile'),
                  ),
                  _NavTile(
                    icon: Icons.auto_awesome,
                    title: 'Фан-функции',
                    onTap: () {}, // зарезервировано
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [AppColors.burgundy, AppColors.navy],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withOpacity(0.35),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Добро пожаловать в Хогвартс', style: textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Исследуй факультеты, заклинания, палочки и карту замка.',
            style: textTheme.bodyMedium?.copyWith(color: AppColors.parchment),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            children: [
              Chip(
                label: const Text('Факультеты'),
                backgroundColor: Colors.white.withOpacity(0.08),
              ),
              Chip(
                label: const Text('Заклинания'),
                backgroundColor: Colors.white.withOpacity(0.08),
              ),
              Chip(
                label: const Text('Палочки'),
                backgroundColor: Colors.white.withOpacity(0.08),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.04),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.gold),
            const SizedBox(height: 8),
            Text(title, style: textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
