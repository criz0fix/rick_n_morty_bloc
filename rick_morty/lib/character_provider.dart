import 'package:flutter/cupertino.dart';
import 'package:rick_morty/character.dart';
import 'package:rick_morty/characters_api.dart';

enum ProviderStates { initialized, loading, loaded, error }

class CharacterProvider with ChangeNotifier {
  ProviderStates state;
  String errorMessage = 'Error. Something is wrong';
  List<Character> characterList;
  CharacterProvider({required this.state, required this.characterList});

  void _changeState(ProviderStates newState) {
    state = newState;
    notifyListeners();
  }

  Future<void> getList() async {
    _changeState(ProviderStates.loading);
    await CharacterApi().requestCharacters().then((data) {
      characterList = data;
      _changeState(ProviderStates.loaded);
    }).catchError((e) {
      errorMessage = e.toString();
      _changeState(ProviderStates.error);
    });
  }
}
