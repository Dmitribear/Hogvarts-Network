import 'wand.dart';

class Character {
  const Character({
    required this.name,
    required this.house,
    required this.image,
    required this.patronus,
    required this.wand,
    required this.actor,
  });

  final String name;
  final String house;
  final String image;
  final String patronus;
  final Wand wand;
  final String actor;
}
