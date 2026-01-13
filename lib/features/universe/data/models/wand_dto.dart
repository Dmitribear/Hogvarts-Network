import '../../domain/entities/wand.dart';

class WandDto {
  WandDto({
    required this.wood,
    required this.core,
    required this.length,
  });

  final String wood;
  final String core;
  final dynamic length; // API может вернуть int/double/null

  factory WandDto.fromJson(Map<String, dynamic> json) {
    return WandDto(
      wood: json['wood'] as String? ?? 'Неизвестная древесина',
      core: json['core'] as String? ?? 'Неизвестное ядро',
      length: json['length'],
    );
  }

  Wand toDomain() {
    final lengthString = switch (length) {
      null => 'Неизвестно',
      int v => '$v"',
      double v => '${v.toStringAsFixed(1)}"',
      _ => length.toString(),
    };

    return Wand(
      wood: wood,
      core: core,
      length: lengthString,
    );
  }
}
