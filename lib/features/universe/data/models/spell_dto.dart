import '../../domain/entities/spell.dart';

class SpellDto {
  SpellDto({
    required this.name,
    required this.description,
  });

  final String name;
  final String description;

  factory SpellDto.fromJson(Map<String, dynamic> json) {
    return SpellDto(
      name: json['name'] as String? ?? 'Безымянное заклинание',
      description: json['description'] as String? ?? 'Нет описания',
    );
  }

  Spell toDomain() => Spell(name: name, description: description);
}
