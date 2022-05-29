import 'dart:convert';

import 'package:rick_morty/character.dart';
import 'package:http/http.dart' as http;
import 'package:rick_morty/character_model.dart';

class CharacterApi {
  Future<List<Character>> requestCharacters() async {
    const url = 'https://rickandmortyapi.com/api/character/?page=19';
    final response = await http.get(Uri.parse(url));
    try {
      return (jsonDecode(response.body)['results'] as List)
          .map((character) => CharacterModel.fromJson(character))
          .toList();
    } catch (e) {
      throw Exception('${response.statusCode}');
    }
  }
}
