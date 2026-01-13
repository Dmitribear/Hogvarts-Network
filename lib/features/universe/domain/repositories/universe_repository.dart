import '../entities/character.dart';
import '../entities/house.dart';
import '../entities/spell.dart';

abstract class UniverseRepository {
  Future<List<Character>> fetchCharacters();
  Future<List<Spell>> fetchSpells();
  Future<List<House>> fetchHouses();
}
