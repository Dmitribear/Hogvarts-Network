import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../home/presentation/widgets/app_bottom_nav.dart';
import '../providers/universe_providers.dart';

final _searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final _roleFilterProvider = StateProvider.autoDispose<String>((ref) => 'all'); // all/students/staff/house
final _houseFilterProvider = StateProvider.autoDispose<String?>((ref) => null);

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(_roleFilterProvider);
    final selectedHouse = ref.watch(_houseFilterProvider);
    final characters = switch (role) {
      'students' => ref.watch(studentsProvider),
      'staff' => ref.watch(staffProvider),
      'house' when (selectedHouse != null && selectedHouse.isNotEmpty) =>
        ref.watch(houseCharactersProvider(selectedHouse)),
      _ => ref.watch(charactersProvider),
    };
    final spells = ref.watch(spellsProvider);
    final houses = ref.watch(housesProvider);
    final query = ref.watch(_searchQueryProvider).trim().toLowerCase();

    return Scaffold(
      appBar: AppBar(title: const Text('Библиотека')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _SearchField(
              initial: query,
              onChanged: (v) => ref.read(_searchQueryProvider.notifier).state = v,
            ),
            const SizedBox(height: 16),
            _Section(
              title: 'Персонажи',
              child: characters.when(
                data: (items) {
                  final filtered = query.isEmpty
                      ? items
                      : items
                          .where((c) =>
                              c.name.toLowerCase().contains(query) ||
                              c.house.toLowerCase().contains(query))
                          .toList();
                  if (filtered.isEmpty) {
                    return const _FallbackInfo(
                      title: 'Ничего не найдено',
                      body: 'Измени запрос или попробуй другой раздел.',
                    );
                  }
                  return SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: filtered.length.clamp(0, 10),
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final c = filtered[index];
                        return _CharacterCard(
                          name: c.name,
                          house: c.house,
                          patronus: c.patronus,
                          image: c.image,
                        );
                      },
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const _FallbackInfo(
                  title: 'Персонажи недоступны',
                  body:
                      'Запуск на web даёт MissingPluginException. Открой на Windows/Android или подключи web-совместимый источник данных.',
                ),
              ),
            ),
            const SizedBox(height: 16),
            _Section(
              title: 'Заклинания',
              child: spells.when(
                data: (items) {
                  final filtered = query.isEmpty
                      ? items
                      : items
                          .where((s) =>
                              s.name.toLowerCase().contains(query) ||
                              s.description.toLowerCase().contains(query))
                          .toList();
                  if (filtered.isEmpty) {
                    return const _FallbackInfo(
                      title: 'Ничего не найдено',
                      body: 'Попробуй другой запрос или раздел.',
                    );
                  }
                  return Column(
                    children: filtered.take(8).map((s) {
                      return ListTile(
                        title: Text(s.name),
                        subtitle: Text(s.description),
                        leading:
                            const Icon(Icons.auto_awesome, color: AppColors.gold),
                      );
                    }).toList(),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const _FallbackInfo(
                  title: 'Заклинания недоступны',
                  body:
                      'Открой приложение на поддерживаемой платформе (Windows/Android) или замени источник данных на web API.',
                ),
              ),
            ),
            const SizedBox(height: 16),
            _Section(
              title: 'Факультеты',
              child: houses.when(
                data: (items) {
                  final filtered = query.isEmpty
                      ? items
                      : items
                          .where(
                              (h) => h.name.toLowerCase().contains(query))
                          .toList();
                  if (filtered.isEmpty) {
                    return const _FallbackInfo(
                      title: 'Ничего не найдено',
                      body: 'Попробуй другой запрос.',
                    );
                  }
                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: filtered
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
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const _FallbackInfo(
                  title: 'Факультеты недоступны',
                  body:
                      'Запусти на поддерживаемой платформе или подставь web API для данных факультетов.',
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }
}

class _FallbackInfo extends StatelessWidget {
  const _FallbackInfo({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: textTheme.titleMedium?.copyWith(color: AppColors.parchment)),
          const SizedBox(height: 6),
          Text(
            body,
            style: textTheme.bodySmall
                ?.copyWith(color: AppColors.parchment.withOpacity(0.75)),
          ),
        ],
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
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: image.isNotEmpty
                  ? Image.network(image, fit: BoxFit.cover)
                  : Container(
                      color: Colors.black26,
                      child: const Icon(Icons.person, size: 42),
                    ),
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

class _SearchField extends StatefulWidget {
  const _SearchField({required this.initial, required this.onChanged});

  final String initial;
  final ValueChanged<String> onChanged;

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial);
    _controller.addListener(() => widget.onChanged(_controller.text));
  }

  @override
  void didUpdateWidget(covariant _SearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initial != widget.initial && widget.initial != _controller.text) {
      _controller.text = widget.initial;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Поиск по персонажам, заклинаниям и факультетам',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gold, width: 1.4),
        ),
      ),
    );
  }
}

class _FiltersBar extends ConsumerWidget {
  const _FiltersBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(_roleFilterProvider);
    final houses = ref.watch(housesProvider);
    final selectedHouse = ref.watch(_houseFilterProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: [
            _roleChip(ref, 'Все', 'all'),
            _roleChip(ref, 'Студенты', 'students'),
            _roleChip(ref, 'Преподаватели', 'staff'),
            _roleChip(ref, 'По факультету', 'house'),
          ],
        ),
        if (role == 'house')
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: houses.when(
              data: (items) {
                final names = items.map((h) => h.name).toList();
                return DropdownButtonFormField<String>(
                  value: selectedHouse?.isNotEmpty == true ? selectedHouse : null,
                  decoration: InputDecoration(
                    hintText: 'Выберите факультет',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                  ),
                  items: names
                      .map((h) => DropdownMenuItem<String>(
                            value: h,
                            child: Text(h),
                          ))
                      .toList(),
                  onChanged: (v) => ref.read(_houseFilterProvider.notifier).state = v,
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
      ],
    );
  }

  Widget _roleChip(WidgetRef ref, String label, String value) {
    final current = ref.watch(_roleFilterProvider);
    return ChoiceChip(
      label: Text(label),
      selected: current == value,
      onSelected: (_) => ref.read(_roleFilterProvider.notifier).state = value,
      selectedColor: AppColors.gold.withOpacity(0.2),
      backgroundColor: Colors.white.withOpacity(0.05),
      labelStyle: TextStyle(
        color: AppColors.parchment,
      ),
    );
  }
}
