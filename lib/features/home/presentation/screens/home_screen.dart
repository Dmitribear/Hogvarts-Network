import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              // Общий фон: атмосфера Хогвартса, тёплый вечер
              'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1600&q=80',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.68),
                Colors.black.withOpacity(0.42),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopBar(textTheme: textTheme),
                  const SizedBox(height: 12),
                  _HeroCard(textTheme: textTheme),
                  const SizedBox(height: 18),
                  _InfoRow(textTheme: textTheme),
                  const SizedBox(height: 18),
                  _TilesGrid(onNavigate: (route) => context.push(route)),
                  const SizedBox(height: 22),
                  _SectionHeader(textTheme: textTheme, title: 'Последние новости'),
                  const SizedBox(height: 12),
                  _NewsRow(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNav(),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.castle, color: AppColors.gold, size: 24),
            const SizedBox(width: 10),
            Text(
              'Hogwarts Network',
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.parchment.withOpacity(0.9),
                letterSpacing: 1.05,
              ),
            ),
          ],
        ),
        Wrap(
          spacing: 16,
          children: const [
            _TopLink(label: 'Новости'),
            _TopLink(label: 'Курсы'),
            _TopLink(label: 'Форум'),
            _TopLink(label: 'Магазин'),
            _TopLink(label: 'Профиль'),
            _TopLink(label: 'Выход'),
          ],
        ),
      ],
    );
  }
}

class _TopLink extends StatelessWidget {
  const _TopLink({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.parchment,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 260,
            child: Image.network(
              // Основной hero фон: ночной замок
              'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=1600&q=80',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.75),
                    Colors.black.withOpacity(0.25),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Добро пожаловать в',
                  style: textTheme.titleMedium
                      ?.copyWith(color: AppColors.parchment),
                ),
                Text(
                  'Hogwarts Network',
                  style: textTheme.headlineLarge?.copyWith(
                    color: AppColors.parchment,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Откройте мир волшебства!',
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColors.parchment.withOpacity(0.9)),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _PrimaryButton(
                      label: 'Изучить курсы',
                      onTap: () => context.push('/home/library'),
                    ),
                    const SizedBox(width: 12),
                    _SecondaryButton(
                      label: 'Присоединиться',
                      onTap: () => context.push('/home/profile'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _InfoChip(textTheme: textTheme, icon: Icons.auto_stories, label: 'Изучить курсы'),
        const SizedBox(width: 10),
        _InfoChip(textTheme: textTheme, icon: Icons.forum, label: 'Присоединиться'),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.textTheme,
    required this.icon,
    required this.label,
  });

  final TextTheme textTheme;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.parchment, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.parchment),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.textTheme, required this.title});

  final TextTheme textTheme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: textTheme.titleLarge?.copyWith(
            color: AppColors.parchment,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Divider(
            color: Colors.white.withOpacity(0.15),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class _TilesGrid extends StatelessWidget {
  const _TilesGrid({required this.onNavigate});

  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 16) / 3;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _TileCard(
                title: 'Курсы Магии',
                subtitle: 'Онлайн-уроки и задания',
                imageUrl:
                    'https://images.unsplash.com/photo-1455884981818-54cb785db6fc?auto=format&fit=crop&w=1200&q=80',
                onTap: () => onNavigate('/home/library'),
                width: cardWidth,
              ),
              const SizedBox(width: 8),
              _TileCard(
                title: 'Новости',
                subtitle: 'Свежие новости из мира магии',
                imageUrl:
                    'https://images.unsplash.com/photo-1505761671935-60b3a7427bad?auto=format&fit=crop&w=1200&q=80',
                onTap: () => onNavigate('/home/library'),
                width: cardWidth,
              ),
              const SizedBox(width: 8),
              _TileCard(
                title: 'Форум',
                subtitle: 'Общение с волшебниками',
                imageUrl:
                    'https://images.unsplash.com/photo-1508057198894-247b23fe5ade?auto=format&fit=crop&w=1200&q=80',
                onTap: () => onNavigate('/home/profile'),
                width: cardWidth,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TileCard extends StatelessWidget {
  const _TileCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.onTap,
    required this.width,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        width: width,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.65),
                Colors.black.withOpacity(0.2),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                title,
                style: textTheme.titleMedium
                    ?.copyWith(color: AppColors.parchment),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.parchment.withOpacity(0.85),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsRow extends StatelessWidget {
  _NewsRow({super.key});

  final _items = const [
    ('Фестиваль в Хогсмиде', '21 апреля 2024'),
    ('Новые зелеварные рецепты', '18 апреля 2024'),
    ('Турнир по квиддичу', '15 апреля 2024'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _items
          .map(
            (e) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1F2538), Color(0xFF0F1325)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.photo, color: AppColors.gold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      e.$1,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.parchment),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      e.$2,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.parchment.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.burgundy.withOpacity(0.9),
        foregroundColor: AppColors.parchment.withOpacity(0.95),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
      ),
      child: Text(label),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.parchment.withOpacity(0.7)),
        foregroundColor: AppColors.parchment.withOpacity(0.9),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      backgroundColor: const Color(0xFF0F1324),
      selectedItemColor: AppColors.gold,
      unselectedItemColor: AppColors.parchment.withOpacity(0.7),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
        BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined), label: 'Задания'),
        BottomNavigationBarItem(
            icon: Icon(Icons.markunread_outlined), label: 'Сообщения'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined), label: 'Магазин'),
      ],
      onTap: (index) {},
    );
  }
}
