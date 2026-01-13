import '../../domain/entities/house.dart';

class HouseDto {
  HouseDto({
    required this.name,
    required this.founder,
    required this.mascot,
    required this.colors,
  });

  final String name;
  final String founder;
  final String mascot;
  final List<String> colors;

  factory HouseDto.fromJson(Map<String, dynamic> json) {
    return HouseDto(
      name: json['name'] as String? ?? 'Факультет',
      founder: json['founder'] as String? ?? 'Основатель не указан',
      mascot: json['mascot'] as String? ?? 'Нет маскота',
      colors: List<String>.from(json['colors'] as List? ?? []),
    );
  }

  House toDomain() => House(
        name: name,
        founder: founder,
        mascot: mascot,
        colors: colors,
      );
}
