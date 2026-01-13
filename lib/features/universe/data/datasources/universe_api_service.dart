import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../models/character_dto.dart';
import '../models/house_dto.dart';
import '../models/spell_dto.dart';

class UniverseApiService {
  UniverseApiService(this._dio);

  final Dio _dio;

  Future<List<CharacterDto>> getCharacters() async {
    try {
      final response = await _dio.get(ApiConstants.characters);
      final data = response.data as List<dynamic>;
      return data.map((json) => CharacterDto.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw AppException('Не удалось загрузить персонажей: $e');
    }
  }

  Future<List<SpellDto>> getSpells() async {
    try {
      final response = await _dio.get(ApiConstants.spells);
      final data = response.data as List<dynamic>;
      return data.map((json) => SpellDto.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw AppException('Не удалось загрузить заклинания: $e');
    }
  }

  Future<List<HouseDto>> getHouses() async {
    try {
      final response = await _dio.get(ApiConstants.houses);
      final data = response.data as List<dynamic>;
      return data.map((json) => HouseDto.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw AppException('Не удалось загрузить факультеты: $e');
    }
  }
}
