import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/fan_profile.dart';
import '../providers/profile_providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameCtrl = TextEditingController();
  final _patronusCtrl = TextEditingController();
  final _wandCtrl = TextEditingController();
  final _achievementCtrl = TextEditingController();
  final _favoriteCtrl = TextEditingController();
  String _house = 'Не распределён';
  String _avatar = '';
  String _cursorSkin = 'default';
  bool _initialized = false;
  bool _saving = false;

  static const _houseOptions = [
    'Не распределён',
    'Gryffindor',
    'Slytherin',
    'Ravenclaw',
    'Hufflepuff',
  ];

  static const _avatarOptions = ['🧙', '🦉', '🦁', '🐍', '🦅', '🦡', '⚡', '📜', '🪄', '✨'];
  static const _cursorOptions = [
    {'value': 'default', 'label': 'Обычный'},
    {'value': 'wand', 'label': 'Палочка'},
    {'value': 'owl', 'label': 'Сова'},
  ];

  void _syncControllers(FanProfile data) {
    if (_initialized) return;
    _nameCtrl.text = data.name;
    _patronusCtrl.text = data.patronus;
    _wandCtrl.text = data.wand;
    _house = data.house;
    _avatar = data.avatarUrl;
    _cursorSkin = data.cursorSkin;
    _initialized = true;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _patronusCtrl.dispose();
    _wandCtrl.dispose();
    _achievementCtrl.dispose();
    _favoriteCtrl.dispose();
    super.dispose();
  }

  Future<void> _save(FanProfile base, {List<String>? achievements, List<String>? favorites}) async {
    setState(() => _saving = true);
    await ref.read(fanProfileProvider.notifier).save(
          base.copyWith(
            name: _nameCtrl.text.trim().isEmpty ? base.name : _nameCtrl.text.trim(),
            patronus: _patronusCtrl.text.trim().isEmpty ? 'Неизвестен' : _patronusCtrl.text.trim(),
            wand: _wandCtrl.text.trim().isEmpty ? 'Неизвестная палочка' : _wandCtrl.text.trim(),
            house: _house,
            avatarUrl: _avatar,
            cursorSkin: _cursorSkin,
            achievements: achievements ?? base.achievements,
            favorites: favorites ?? base.favorites,
          ),
        );
    if (mounted) setState(() => _saving = false);
  }

  Future<void> _logout() async {
    await ref.read(authRepositoryProvider).logout();
    if (mounted) context.go('/auth/login');
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(fanProfileProvider);
    final loginAsync = ref.watch(storedLoginProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль фаната'),
        actions: [
          TextButton(
            onPressed: _logout,
            child: const Text(
              'Выйти',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: MouseRegion(
        cursor: _cursorSkin == 'wand'
            ? SystemMouseCursors.precise
            : _cursorSkin == 'owl'
                ? SystemMouseCursors.grab
                : SystemMouseCursors.basic,
        child: Padding(
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
                    cursorSkin: 'default',
                  );
              _syncControllers(data);

              Widget avatarWidget;
              if (_avatar.isNotEmpty && !_avatar.startsWith('emoji:')) {
                avatarWidget = CircleAvatar(
                  radius: 42,
                  backgroundColor: AppColors.gold.withOpacity(0.2),
                  backgroundImage: NetworkImage(_avatar),
                );
              } else {
                final emoji = _avatar.isNotEmpty ? _avatar.replaceFirst('emoji:', '') : '🧙';
                avatarWidget = CircleAvatar(
                  radius: 42,
                  backgroundColor: AppColors.gold.withOpacity(0.15),
                  child: Text(emoji, style: const TextStyle(fontSize: 30)),
                );
              }

              return ListView(
                children: [
                  Row(
                    children: [
                      avatarWidget,
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.name, style: textTheme.titleLarge),
                            const SizedBox(height: 4),
                            Text(
                              'Факультет: $_house',
                              style: textTheme.bodyMedium?.copyWith(color: AppColors.gold),
                            ),
                            const SizedBox(height: 4),
                            loginAsync.maybeWhen(
                              data: (login) => Text(
                                'Логин: ${login ?? 'не задан'}',
                                style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                              ),
                              orElse: () => const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Аватар', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _avatarOptions
                        .map((emoji) => ChoiceChip(
                              label: Text(emoji, style: const TextStyle(fontSize: 18)),
                              selected: _avatar == 'emoji:$emoji',
                              onSelected: (_) => setState(() => _avatar = 'emoji:$emoji'),
                              selectedColor: AppColors.gold.withOpacity(0.25),
                              backgroundColor: Colors.white.withOpacity(0.06),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  Text('Курсор', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _cursorOptions
                        .map(
                          (opt) => ChoiceChip(
                            label: Text(opt['label']!),
                            selected: _cursorSkin == opt['value'],
                            onSelected: (_) => setState(() => _cursorSkin = opt['value']!),
                            selectedColor: AppColors.gold.withOpacity(0.25),
                            backgroundColor: Colors.white.withOpacity(0.06),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  Text('Имя', style: textTheme.labelLarge),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Как тебя назвать?',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Факультет', style: textTheme.labelLarge),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: _houseOptions.contains(_house) ? _house : _houseOptions.first,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    items: _houseOptions
                        .map((h) => DropdownMenuItem(value: h, child: Text(h)))
                        .toList(),
                    onChanged: (v) => setState(() => _house = v ?? _houseOptions.first),
                  ),
                  const SizedBox(height: 12),
                  Text('Патронус', style: textTheme.labelLarge),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _patronusCtrl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Например: Феникс',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Палочка', style: textTheme.labelLarge),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _wandCtrl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Древесина / сердце / длина',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _saving ? null : () => _save(data),
                    icon: _saving
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save),
                    label: const Text('Сохранить профиль'),
                  ),
                  const SizedBox(height: 24),
                  Text('Достижения', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
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
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _achievementCtrl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Добавить достижение',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: _saving
                            ? null
                            : () {
                                final text = _achievementCtrl.text.trim();
                                if (text.isEmpty) return;
                                final updated = [
                                  ...data.achievements.where((a) => a != text),
                                  text,
                                ];
                                _achievementCtrl.clear();
                                _save(data, achievements: updated);
                              },
                        child: const Text('Добавить'),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Избранное', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (data.favorites.isEmpty
                            ? ['Добавь книги, заклинания, персонажей']
                            : data.favorites)
                        .map(
                      (fav) => Chip(
                        label: Text(fav),
                        backgroundColor: Colors.white.withOpacity(0.06),
                      ),
                    ).toList(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _favoriteCtrl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Добавить в избранное (книга/заклинание)',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: _saving
                            ? null
                            : () {
                                final text = _favoriteCtrl.text.trim();
                                if (text.isEmpty) return;
                                final updated = [
                                  ...data.favorites.where((a) => a != text),
                                  text,
                                ];
                                _favoriteCtrl.clear();
                                _save(data, favorites: updated);
                              },
                        child: const Text('Добавить'),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  _InfoTile(
                    title: 'Патронус',
                    value: _patronusCtrl.text.trim().isEmpty
                        ? data.patronus
                        : _patronusCtrl.text.trim(),
                    icon: Icons.auto_awesome,
                  ),
                  _InfoTile(
                    title: 'Палочка',
                    value: _wandCtrl.text.trim().isEmpty ? data.wand : _wandCtrl.text.trim(),
                    icon: Icons.bolt,
                  ),
                ],
              );
            },
          ),
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
