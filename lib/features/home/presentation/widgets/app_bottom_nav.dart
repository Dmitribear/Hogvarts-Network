import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: const Color(0xFF0F1324),
      selectedItemColor: AppColors.gold,
      unselectedItemColor: AppColors.parchment.withOpacity(0.7),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
        BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Задания'),
        BottomNavigationBarItem(icon: Icon(Icons.markunread_outlined), label: 'Сообщения'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Магазин'),
      ],
      onTap: (index) {
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
    );
  }
}
