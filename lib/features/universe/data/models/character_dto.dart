import '../../domain/entities/character.dart';
import '../../domain/entities/wand.dart';
import 'wand_dto.dart';

class CharacterDto {
  CharacterDto({
    required this.name,
    required this.house,
    required this.image,
    required this.patronus,
    required this.actor,
    required this.wand,
  });

  final String name;
  final String house;
  final String image;
  final String patronus;
  final String actor;
  final WandDto wand;

  factory CharacterDto.fromJson(Map<String, dynamic> json) {
    return CharacterDto(
      name: json['name'] as String? ?? 'Неизвестный маг',
      house: json['house'] as String? ?? 'Без факультета',
      image: json['image'] as String? ?? '',
      patronus: json['patronus'] as String? ?? 'Неизвестен',
      actor: json['actor'] as String? ?? '',
      wand: WandDto.fromJson(json['wand'] as Map<String, dynamic>? ?? {}),
    );
  }

  Character toDomain() => Character(
        name: name,
        house: house,
        image: image,
        patronus: patronus,
        actor: actor,
        wand: wand.toDomain(),
      );
}
