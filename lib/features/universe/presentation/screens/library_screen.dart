import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/universe_providers.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(charactersProvider);
    final spells = ref.watch(spellsProvider);
    final houses = ref.watch(housesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Библиотека вселенной')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _Section(
              title: 'Персонажи',
              child: characters.when(
                data: (items) => SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.take(10).length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final c = items[index];
                      return _CharacterCard(
                        name: c.name,
                        house: c.house,
                        patronus: c.patronus,
                        image: c.image,
                      );
                    },
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Ошибка: $e'),
              ),
            ),
            const SizedBox(height: 12),
            _Section(
              title: 'Заклинания',
              child: spells.when(
                data: (items) => Column(
                  children: items.take(6).map((s) {
                    return ListTile(
                      title: Text(s.name),
                      subtitle: Text(s.description),
                      leading: const Icon(Icons.auto_awesome, color: AppColors.gold),
                    );
                  }).toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Ошибка: $e'),
              ),
            ),
            const SizedBox(height: 12),
            _Section(
              title: 'Факультеты',
              child: houses.when(
                data: (items) => Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: items
                      .map(
                        (h) => Chip(
                          label: Text(h.name),
                          avatar: CircleAvatar(
                            backgroundColor: AppColors.gold.withOpacity(0.2),
                            child: Text(h.name.characters.first),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.06),
                        ),
                      )
                      .toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Ошибка: $e'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.titleLarge),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _CharacterCard extends StatelessWidget {
  const _CharacterCard({
    required this.name,
    required this.house,
    required this.patronus,
    required this.image,
  });

  final String name;
  final String house;
  final String patronus;
  final String image;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withOpacity(0.06),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: image.isNotEmpty
                ? Image.network(image, height: 100, width: double.infinity, fit: BoxFit.cover)
                : Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.black26,
                    child: const Icon(Icons.person, size: 42),
                  ),
          ),
          const SizedBox(height: 8),
          Text(name, style: textTheme.titleMedium),
          Text(house, style: textTheme.bodySmall?.copyWith(color: AppColors.gold)),
          Text('Патронус: $patronus',
              style: textTheme.bodySmall?.copyWith(color: Colors.white70)),
        ],
      ),
    );
  }
}
