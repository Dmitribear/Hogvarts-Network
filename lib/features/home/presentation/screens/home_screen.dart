import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isMobile = MediaQuery.of(context).size.width < 720;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0B1029),
                    Color(0xFF0E1538),
                    Color(0xFF181D3F),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
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
                  _TopBar(textTheme: textTheme, isMobile: isMobile),
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
                  const SizedBox(height: 22),
                  _SectionHeader(textTheme: textTheme, title: 'Возможности для вас'),
                  const SizedBox(height: 12),
                  _FeaturesList(textTheme: textTheme),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.textTheme, required this.isMobile});

  final TextTheme textTheme;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final menu = [
      ('Новости', '/home/news'),
      ('Библиотека', '/home/library'),
      ('Сообщество', '/home/forum'),
      ('Магазин', '/home/shop'),
      ('Профиль', '/home/profile'),
    ];

    if (isMobile) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.castle, color: AppColors.gold, size: 24),
              const SizedBox(width: 10),
              Text(
              'Wizarding Hub',
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.parchment.withOpacity(0.9),
                  letterSpacing: 1.05,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.parchment),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: const Color(0xFF0F1324),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: menu
                      .map(
                        (m) => ListTile(
                          title: Text(
                            m.$1,
                            style: textTheme.titleMedium
                                ?.copyWith(color: AppColors.parchment),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            context.go(m.$2);
                          },
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.castle, color: AppColors.gold, size: 24),
            const SizedBox(width: 10),
            Text(
              'Wizarding Hub',
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.parchment.withOpacity(0.9),
                letterSpacing: 1.05,
              ),
            ),
          ],
        ),
        Wrap(
          spacing: 16,
          children: menu
              .map(
                (m) => _TopLink(label: m.$1, onTap: () => context.go(m.$2)),
              )
              .toList(),
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
              asset: 'assets/images/bg_main.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.72),
                    Colors.black.withOpacity(0.35),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          const Positioned(
            right: 16,
            top: 14,
            child: Icon(Icons.shield, color: AppColors.gold),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Официальный портал',
                  style: textTheme.titleMedium
                      ?.copyWith(color: AppColors.parchment.withOpacity(0.9)),
                ),
                Text(
                  'Wizarding World',
                  style: textTheme.headlineLarge?.copyWith(
                    color: AppColors.parchment,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Новости, истории, события и уникальный контент\nвдохновлённый миром волшебства.',
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColors.parchment.withOpacity(0.9)),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _PrimaryButton(
                      label: 'Войти в мир магии',
                      onTap: () => context.push('/home/library'),
                    ),
                    const SizedBox(width: 12),
                    _SecondaryButton(
                      label: 'Профиль',
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
        final cardWidth = (constraints.maxWidth - 24) / 2;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _TileCard(
                title: 'Персонажи',
                subtitle: 'Поиск героев и статистика',
                imageAsset: 'assets/images/card_courses.jpg',
                onTap: () => onNavigate('/home/library'),
                width: cardWidth,
              ),
              const SizedBox(width: 8),
              _TileCard(
                title: 'Книга и лор',
                subtitle: 'Читай и изучай вселенную',
                imageAsset: 'assets/images/card_news.jpg',
                onTap: () => onNavigate('/home/news'),
                width: cardWidth,
              ),
              const SizedBox(width: 8),
              _TileCard(
                title: 'Сообщество',
                subtitle: 'Форум и обсуждения',
                imageAsset: 'assets/images/card_forum.jpg',
                onTap: () => onNavigate('/home/forum'),
                width: cardWidth,
              ),
              const SizedBox(width: 8),
              _TileCard(
                title: 'Квизы и задания',
                subtitle: 'Проверь знания, получи бейджи',
                imageAsset: 'assets/images/card_courses.jpg',
                onTap: () => onNavigate('/home/tasks'),
                width: cardWidth,
              ),
              const SizedBox(width: 8),
              _TileCard(
                title: 'Профиль и кастомизация',
                subtitle: 'Аватар, палочка, Патронус',
                imageAsset: 'assets/images/card_forum.jpg',
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

class _FeaturesList extends StatelessWidget {
  const _FeaturesList({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Поиск персонажей', 'Карточки, биография, статы из API'),
      ('Профиль и интересы', 'Аватар, подборки, рекомендации'),
      ('Квизы и тесты', 'Самопроверка, бейджи, прогресс'),
      ('Книги и статьи', 'Чтение материалов, подборки, лонгриды'),
      ('Сообщество', 'Форумы, обсуждения, вопросы-ответы'),
      ('Магазин', 'Книги, мерч, постеры, аксессуары'),
    ];
    return Column(
      children: items
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: AppColors.gold, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.$1,
                          style: textTheme.titleSmall
                              ?.copyWith(color: AppColors.parchment),
                        ),
                        Text(
                          e.$2,
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
          )
          .toList(),
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
                      Colors.deepPurple.withOpacity(0.55),
                      Colors.black.withOpacity(0.18),
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
    ('Обновление API персонажей', 'Свежие данные и карточки'),
    ('Квиз по лору', 'Проверь знания книг и фильмов'),
    ('Новая подборка статей', 'Лучшие материалы недели'),
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
