import '../models/creature_dto.dart';
import '../../domain/entities/creature.dart';

extension CreatureMapper on CreatureDto {
  Creature toEntity() {
    return Creature(
      name: name.isEmpty ? 'Неизвестное существо' : name,
      description: description.isEmpty ? 'Описание недоступно' : description,
      image: image,
    );
  }
}
