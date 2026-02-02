import '../entities/character.dart';
import '../entities/house.dart';
import '../entities/spell.dart';
import '../entities/creature.dart';

abstract class UniverseRepository {
  Future<List<Character>> fetchCharacters();
  Future<List<Character>> fetchStudents();
  Future<List<Character>> fetchStaff();
  Future<List<Character>> fetchCharactersByHouse(String house);
  Future<List<Spell>> fetchSpells();
  Future<List<House>> fetchHouses();
  Future<List<Creature>> fetchCreatures();
}
