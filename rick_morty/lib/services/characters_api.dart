import 'dart:convert';
import 'dart:developer';

import 'package:rick_morty/models/character.dart';
import 'package:http/http.dart' as http;
import 'package:rick_morty/models/character_model.dart';

class CharacterApi {
  Future<List<Character>> requestCharacters(
    int pageNum,
  ) async {
    String url = 'https://rickandmortyapi.com/api/character/?page=$pageNum';
    final response = await http.get(Uri.parse(url));
    try {
      log(response.statusCode.toString());
      return (jsonDecode(response.body)['results'] as List)
          .map((character) => CharacterModel.fromJson(character))
          .toList();
    } catch (e) {
      throw Exception('${response.statusCode}');
    }
  }
}
