import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final items = [
      _ShopItem('Книга о съёмках HP', 'Артбук, 320 стр.', '1 990 ₽',
          '000503926dba473ea9ccabbb23705041.webp'),
      _ShopItem('Постер Хогвартса', 'Формат A2, матовая бумага', '690 ₽',
          'Hogwarts-Express-1-1024x635.jpg'),
      _ShopItem('Хогвартс-экспресс', 'Металлический значок', '490 ₽', 'images (64).jfif'),
      _ShopItem('Кулинарная книга HP', 'С рецептами, полноцвет', '1 290 ₽',
          '25fDAOTDkC2lIef7QqHF0v9fTJ-0Qis_.jpg'),
      _ShopItem('Светильник в виде замка', 'Настольный, USB', '2 490 ₽',
          '391b1e7d4bf64d8da69fc4592f4a9bf7.webp'),
      _ShopItem('Худи фандом', 'Черный, принт Hogwarts', '3 490 ₽', 'images (65).jfif'),
      _ShopItem('Шарф в цветах факультета', 'Мягкий акрил, зима', '1 290 ₽', 'images (66).jfif'),
      _ShopItem('Коллекционная палочка', 'Реплика, коробка-пенал', '2 990 ₽', 'images (67).jfif'),
      _ShopItem('Кружка Hogwarts', 'Керамика, 350 мл', '690 ₽', 'images (68).jfif'),
      _ShopItem('Лава-лампа с символикой', 'Амбиентное освещение', '1 990 ₽',
          'istockphoto-1342209784-612x612.jpg'),
    ];

    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        title: const Text('Магазин'),
        backgroundColor: Colors.black.withOpacity(0.6),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.parchment),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Hogwarts-Express-1-1024x635.jpg'),
            fit: BoxFit.cover,
            opacity: 0.12,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _ShopCard(item: item, textTheme: textTheme);
          },
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
    );
  }
}

class _ShopItem {
  _ShopItem(this.title, this.subtitle, this.price, this.asset);

  final String title;
  final String subtitle;
  final String price;
  final String asset;
}

class _ShopCard extends StatelessWidget {
  const _ShopCard({required this.item, required this.textTheme});

  final _ShopItem item;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.asset(
                  'assets/images/${item.asset}',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.black26,
                    child: const Icon(Icons.image_not_supported, color: Colors.white54),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              style:
                  textTheme.titleMedium?.copyWith(color: AppColors.parchment),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              item.subtitle,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.parchment.withOpacity(0.75),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  item.price,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.gold,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.open_in_new,
                      color: AppColors.parchment),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
