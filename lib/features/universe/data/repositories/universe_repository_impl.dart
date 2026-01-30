import '../../domain/entities/character.dart';
import '../../domain/entities/house.dart';
import '../../domain/entities/spell.dart';
import '../../domain/repositories/universe_repository.dart';
import '../datasources/universe_api_service.dart';

class UniverseRepositoryImpl implements UniverseRepository {
  UniverseRepositoryImpl(this._api);

  final UniverseApiService _api;

  @override
  Future<List<Character>> fetchCharacters() async {
    final result = await _api.getCharacters();
    return result.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<Character>> fetchStudents() async {
    final result = await _api.getStudents();
    return result.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<Character>> fetchStaff() async {
    final result = await _api.getStaff();
    return result.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<Character>> fetchCharactersByHouse(String house) async {
    final result = await _api.getCharactersByHouse(house);
    return result.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<Spell>> fetchSpells() async {
    final result = await _api.getSpells();
    return result.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<House>> fetchHouses() async {
    final result = await _api.getHouses();
    return result.map((dto) => dto.toDomain()).toList();
  }
}
