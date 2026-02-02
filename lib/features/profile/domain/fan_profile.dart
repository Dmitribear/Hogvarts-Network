class FanProfile {
  const FanProfile({
    required this.name,
    required this.house,
    required this.patronus,
    required this.wand,
    required this.avatarUrl,
    required this.cursorSkin,
    this.achievements = const [],
    this.favorites = const [],
  });

  final String name;
  final String house;
  final String patronus;
  final String wand;
  final String avatarUrl;
  final String cursorSkin; // 'default' | 'wand' | 'owl'
  final List<String> achievements;
  final List<String> favorites;

  FanProfile copyWith({
    String? name,
    String? house,
    String? patronus,
    String? wand,
    String? avatarUrl,
    String? cursorSkin,
    List<String>? achievements,
    List<String>? favorites,
  }) {
    return FanProfile(
      name: name ?? this.name,
      house: house ?? this.house,
      patronus: patronus ?? this.patronus,
      wand: wand ?? this.wand,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      cursorSkin: cursorSkin ?? this.cursorSkin,
      achievements: achievements ?? this.achievements,
      favorites: favorites ?? this.favorites,
    );
  }

  factory FanProfile.fromJson(Map<String, dynamic> json) {
    return FanProfile(
      name: json['name'] as String? ?? 'Анонимный маг',
      house: json['house'] as String? ?? 'Не распределён',
      patronus: json['patronus'] as String? ?? 'Неизвестен',
      wand: json['wand'] as String? ?? 'Неизвестная палочка',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      cursorSkin: json['cursorSkin'] as String? ?? 'default',
      achievements: List<String>.from(json['achievements'] as List? ?? []),
      favorites: List<String>.from(json['favorites'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'house': house,
        'patronus': patronus,
        'wand': wand,
        'avatarUrl': avatarUrl,
        'cursorSkin': cursorSkin,
        'achievements': achievements,
        'favorites': favorites,
      };
}
