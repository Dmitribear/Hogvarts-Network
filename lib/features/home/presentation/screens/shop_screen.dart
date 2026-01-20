import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final items = [
      _ShopItem('Волшебная палочка', 'Остролист, сердечная жила дракона', 15),
      _ShopItem('Мантия-невидимка', 'Лёгкая, почти невесомая', 120),
      _ShopItem('Котёл медный', 'Стандарт 2 размера', 8),
      _ShopItem('Метла Firebolt', 'Скорость и манёвренность', 250),
      _ShopItem('Книга заклинаний', '5 курс, проверенный экземпляр', 22),
      _ShopItem('Совушка', 'Надёжная почта в любую погоду', 35),
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
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.82,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _ShopCard(item: item, textTheme: textTheme);
        },
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
    );
  }
}

class _ShopItem {
  _ShopItem(this.title, this.subtitle, this.price);

  final String title;
  final String subtitle;
  final int price;
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
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1F2538), Color(0xFF0F1325)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(Icons.auto_awesome, color: AppColors.gold, size: 32),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.title,
              style:
                  textTheme.titleMedium?.copyWith(color: AppColors.parchment),
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
                  '${item.price} галлеонов',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.gold,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart,
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
