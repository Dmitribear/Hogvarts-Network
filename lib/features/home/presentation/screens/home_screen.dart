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
      body: Stack(
        children: [
          const Positioned.fill(
            child: _AssetImage(asset: 'assets/images/bg_main.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
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
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopBar(textTheme: textTheme),
                  const SizedBox(height: 12),
                  _HeroCard(textTheme: textTheme),
                  const SizedBox(height: 18),
                  _InfoRow(
                    textTheme: textTheme,
                    onCourses: () => context.push('/home/library'),
                    onJoin: () => context.push('/home/profile'),
                  ),
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
        ],
      ),
      bottomNavigationBar: _BottomNav(
        onTab: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/home/tasks');
              break;
            case 2:
              context.go('/home/messages');
              break;
            case 3:
              context.go('/home/shop');
              break;
          }
        },
      ),
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
          children: [
            _TopLink(label: 'Новости', onTap: () => context.go('/home/news')),
            _TopLink(label: 'Курсы', onTap: () => context.go('/home/library')),
            _TopLink(label: 'Форум', onTap: () => context.go('/home/forum')),
            _TopLink(label: 'Магазин', onTap: () => context.go('/home/shop')),
            _TopLink(label: 'Профиль', onTap: () => context.go('/home/profile')),
            _TopLink(label: 'Выход', onTap: () => Navigator.of(context).pop()),
          ],
        ),
      ],
    );
  }
}

class _TopLink extends StatelessWidget {
  const _TopLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.parchment.withOpacity(0.9),
              fontWeight: FontWeight.w600,
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 260,
            child: _AssetImage(
              asset: 'assets/images/hero_castle.jpg',
              fit: BoxFit.cover,
              height: 260,
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
  const _InfoRow({
    required this.textTheme,
    required this.onCourses,
    required this.onJoin,
  });

  final TextTheme textTheme;
  final VoidCallback onCourses;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _InfoChip(
          textTheme: textTheme,
          icon: Icons.auto_stories,
          label: 'Изучить курсы',
          onTap: onCourses,
        ),
        const SizedBox(width: 10),
        _InfoChip(
          textTheme: textTheme,
          icon: Icons.forum,
          label: 'Присоединиться',
          onTap: onJoin,
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.textTheme,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final TextTheme textTheme;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
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
                imageAsset: 'assets/images/card_courses.jpg',
                onTap: () => onNavigate('/home/library'),
                width: cardWidth,
              ),
              const SizedBox(width: 8),
              _TileCard(
                title: 'Новости',
                subtitle: 'Свежие новости из мира магии',
                imageAsset: 'assets/images/card_news.jpg',
                onTap: () => onNavigate('/home/news'),
                width: cardWidth,
              ),
              const SizedBox(width: 8),
              _TileCard(
                title: 'Форум',
                subtitle: 'Общение с волшебниками',
                imageAsset: 'assets/images/card_forum.jpg',
                onTap: () => onNavigate('/home/forum'),
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
    required this.imageAsset,
    required this.onTap,
    required this.width,
  });

  final String title;
  final String subtitle;
  final String imageAsset;
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
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _AssetImage(asset: imageAsset, fit: BoxFit.cover),
              ),
            ),
            Positioned.fill(
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
              ),
            ),
            Padding(
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
          ],
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
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => Navigator.of(context).pushNamed('/home/news'),
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
  const _BottomNav({required this.onTab});

  final ValueChanged<int> onTab;

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
      onTap: onTab,
    );
  }
}

class _AssetImage extends StatelessWidget {
  const _AssetImage({
    required this.asset,
    this.fit,
    this.height,
    this.width,
  });

  final String asset;
  final BoxFit? fit;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      fit: fit,
      height: height,
      width: width,
      errorBuilder: (context, _, __) => Container(
        height: height,
        width: width,
        color: Colors.black.withOpacity(0.3),
      ),
    );
  }
}
