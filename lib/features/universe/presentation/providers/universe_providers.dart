import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/universe_api_service.dart';
import '../../data/repositories/universe_repository_impl.dart';
import '../../domain/entities/character.dart';
import '../../domain/entities/house.dart';
import '../../domain/entities/spell.dart';
import '../../domain/entities/creature.dart';
import '../../domain/repositories/universe_repository.dart';

final dioProvider = FutureProvider<Dio>((ref) async => DioClient.create());

final universeRepositoryProvider = FutureProvider<UniverseRepository>((ref) async {
  final dio = await ref.watch(dioProvider.future);
  return UniverseRepositoryImpl(UniverseApiService(dio));
});

final charactersProvider = FutureProvider<List<Character>>((ref) async {
  final repo = await ref.watch(universeRepositoryProvider.future);
  return repo.fetchCharacters();
});

final studentsProvider = FutureProvider<List<Character>>((ref) async {
  final repo = await ref.watch(universeRepositoryProvider.future);
  return repo.fetchStudents();
});

final staffProvider = FutureProvider<List<Character>>((ref) async {
  final repo = await ref.watch(universeRepositoryProvider.future);
  return repo.fetchStaff();
});

final houseCharactersProvider =
    FutureProvider.family<List<Character>, String>((ref, house) async {
  final repo = await ref.watch(universeRepositoryProvider.future);
  return repo.fetchCharactersByHouse(house);
});

final spellsProvider = FutureProvider<List<Spell>>((ref) async {
  final repo = await ref.watch(universeRepositoryProvider.future);
  return repo.fetchSpells();
});

final housesProvider = FutureProvider<List<House>>((ref) async {
  final repo = await ref.watch(universeRepositoryProvider.future);
  return repo.fetchHouses();
});

final creaturesProvider = FutureProvider<List<Creature>>((ref) async {
  final repo = await ref.watch(universeRepositoryProvider.future);
  return repo.fetchCreatures();
});
