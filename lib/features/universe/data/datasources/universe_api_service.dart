import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../models/character_dto.dart';
import '../models/house_dto.dart';
import '../models/spell_dto.dart';
import '../models/creature_dto.dart';

class UniverseApiService {
  UniverseApiService(this._dio);

  final Dio _dio;

  Future<List<CharacterDto>> getCharacters() async {
    try {
      final List<dynamic> aggregated = [];

      // primary remote (relative to dio.baseUrl)
      try {
        final response = await _dio.get(ApiConstants.characters);
        if (response.data is List) aggregated.addAll(response.data as List<dynamic>);
      } catch (_) {}

      // attempt local backend
      try {
        final localResp = await _dio.get('${ApiConstants.localBaseUrl}${ApiConstants.characters}');
        if (localResp.data is List) aggregated.addAll(localResp.data as List<dynamic>);
      } catch (_) {}

      // dedupe by name (fallback to stringified json when name missing)
      final Map<String, Map<String, dynamic>> unique = {};
      for (final item in aggregated) {
        final map = item as Map<String, dynamic>;
        final key = (map['name'] as String?) ?? (map['id']?.toString()) ?? map.toString();
        unique.putIfAbsent(key, () => map);
      }

      return unique.values.map((json) => CharacterDto.fromJson(json)).toList();
    } catch (e) {
      throw AppException('Не удалось загрузить персонажей: $e');
    }
  }

  Future<List<CharacterDto>> getStudents() async {
    try {
      final List<dynamic> aggregated = [];
      try {
        final response = await _dio.get(ApiConstants.students);
        if (response.data is List) aggregated.addAll(response.data as List<dynamic>);
      } catch (_) {}
      try {
        final localResp =
            await _dio.get('${ApiConstants.localBaseUrl}${ApiConstants.students}');
        if (localResp.data is List) aggregated.addAll(localResp.data as List<dynamic>);
      } catch (_) {}
      final Map<String, Map<String, dynamic>> unique = {};
      for (final item in aggregated) {
        final map = item as Map<String, dynamic>;
        final key = (map['name'] as String?) ?? (map['id']?.toString()) ?? map.toString();
        unique.putIfAbsent(key, () => map);
      }
      return unique.values.map((json) => CharacterDto.fromJson(json)).toList();
    } catch (e) {
      throw AppException('Не удалось загрузить студентов: $e');
    }
  }

  Future<List<CharacterDto>> getStaff() async {
    try {
      final List<dynamic> aggregated = [];
      try {
        final response = await _dio.get(ApiConstants.staff);
        if (response.data is List) aggregated.addAll(response.data as List<dynamic>);
      } catch (_) {}
      try {
        final localResp =
            await _dio.get('${ApiConstants.localBaseUrl}${ApiConstants.staff}');
        if (localResp.data is List) aggregated.addAll(localResp.data as List<dynamic>);
      } catch (_) {}
      final Map<String, Map<String, dynamic>> unique = {};
      for (final item in aggregated) {
        final map = item as Map<String, dynamic>;
        final key = (map['name'] as String?) ?? (map['id']?.toString()) ?? map.toString();
        unique.putIfAbsent(key, () => map);
      }
      return unique.values.map((json) => CharacterDto.fromJson(json)).toList();
    } catch (e) {
      throw AppException('Не удалось загрузить преподавателей: $e');
    }
  }

  Future<List<CharacterDto>> getCharactersByHouse(String house) async {
    try {
      final List<dynamic> aggregated = [];
      try {
        final response = await _dio.get(ApiConstants.charactersByHouse(house));
        if (response.data is List) aggregated.addAll(response.data as List<dynamic>);
      } catch (_) {}
      try {
        final localResp = await _dio
            .get('${ApiConstants.localBaseUrl}${ApiConstants.charactersByHouse(house)}');
        if (localResp.data is List) aggregated.addAll(localResp.data as List<dynamic>);
      } catch (_) {}
      final Map<String, Map<String, dynamic>> unique = {};
      for (final item in aggregated) {
        final map = item as Map<String, dynamic>;
        final key = (map['name'] as String?) ?? (map['id']?.toString()) ?? map.toString();
        unique.putIfAbsent(key, () => map);
      }
      return unique.values.map((json) => CharacterDto.fromJson(json)).toList();
    } catch (e) {
      throw AppException('Не удалось загрузить персонажей факультета: $e');
    }
  }

  Future<List<SpellDto>> getSpells() async {
    try {
      final List<dynamic> aggregated = [];

      try {
        final response = await _dio.get(ApiConstants.spells);
        if (response.data is List) aggregated.addAll(response.data as List<dynamic>);
      } catch (_) {}

      try {
        final localResp = await _dio.get('${ApiConstants.localBaseUrl}${ApiConstants.spells}');
        if (localResp.data is List) aggregated.addAll(localResp.data as List<dynamic>);
      } catch (_) {}

      final Map<String, Map<String, dynamic>> unique = {};
      for (final item in aggregated) {
        final map = item as Map<String, dynamic>;
        final key = (map['name'] as String?) ?? map.toString();
        unique.putIfAbsent(key, () => map);
      }

      return unique.values.map((json) => SpellDto.fromJson(json)).toList();
    } catch (e) {
      throw AppException('Не удалось загрузить заклинания: $e');
    }
  }

  Future<List<HouseDto>> getHouses() async {
    try {
      final List<dynamic> aggregated = [];

      try {
        final response = await _dio.get(ApiConstants.houses);
        if (response.data is List) aggregated.addAll(response.data as List<dynamic>);
      } catch (_) {}

      try {
        final localResp = await _dio.get('${ApiConstants.localBaseUrl}${ApiConstants.houses}');
        if (localResp.data is List) aggregated.addAll(localResp.data as List<dynamic>);
      } catch (_) {}

      final Map<String, Map<String, dynamic>> unique = {};
      for (final item in aggregated) {
        final map = item as Map<String, dynamic>;
        final key = (map['name'] as String?) ?? map.toString();
        unique.putIfAbsent(key, () => map);
      }

      return unique.values.map((json) => HouseDto.fromJson(json)).toList();
    } catch (e) {
      throw AppException('Не удалось загрузить факультеты: $e');
    }
  }

  Future<List<CreatureDto>> getCreatures() async {
    try {
      final List<dynamic> aggregated = [];

      // primary (may 404 on hp-api)
      try {
        final response = await _dio.get(ApiConstants.creatures);
        if (response.data is List) aggregated.addAll(response.data as List<dynamic>);
      } catch (_) {}

      // alternate open API
      try {
        final response = await _dio.get(ApiConstants.altCreatures);
        if (response.data is List) aggregated.addAll(response.data as List<dynamic>);
      } catch (_) {}

      // local backend
      try {
        final localResp =
            await _dio.get('${ApiConstants.localBaseUrl}${ApiConstants.creatures}');
        if (localResp.data is List) aggregated.addAll(localResp.data as List<dynamic>);
      } catch (_) {}

      if (aggregated.isEmpty) {
        // fallback stub if API has no creatures endpoint
        aggregated.addAll([
          {
            'name': 'Хиппогриф',
            'description': 'Гордое крылатое существо, требует поклона и уважения.',
            'image': '',
          },
          {
            'name': 'Феникс',
            'description': 'Возрождается из пепла; слёзы исцеляют.',
            'image': '',
          },
          {
            'name': 'Нюхлер',
            'description': 'Ловко ворует всё блестящее.',
            'image': '',
          },
          {
            'name': 'Тестрал',
            'description': 'Видим лишь теми, кто видел смерть; быстрые летающие кони.',
            'image': '',
          },
        ]);
      }

      final Map<String, Map<String, dynamic>> unique = {};
      for (final item in aggregated) {
        final map = item as Map<String, dynamic>;
        final key = (map['name'] as String?) ?? map.toString();
        unique.putIfAbsent(key, () => map);
      }

      return unique.values.map((json) => CreatureDto.fromJson(json)).toList();
    } catch (e) {
      throw AppException('Не удалось загрузить существ: $e');
    }
  }
}
