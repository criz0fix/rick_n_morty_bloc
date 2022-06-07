import 'package:rick_morty/models/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required String name,
    required String species,
    required String image,
  }) : super(
          name: name,
          species: species,
          image: image,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json['name'] as String,
      species: json['species'] as String,
      image: json['image'] as String,
    );
  }
}
