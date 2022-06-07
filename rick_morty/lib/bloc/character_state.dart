part of 'character_bloc.dart';

enum CharacterStates { initial, loading, loaded, error }

class CharacterState extends Equatable {
  final int pageNum;
  final CharacterStates status;
  final List<Character> loadedCharacter;
  final bool hasMore;
  final String errorMessage;

  const CharacterState(
      {this.loadedCharacter = const <Character>[],
      this.status = CharacterStates.initial,
      this.pageNum = 1,
      this.hasMore = true,
      this.errorMessage = ''});

  @override
  List<Object?> get props =>
      [pageNum, loadedCharacter, status, hasMore, errorMessage];

  CharacterState copyWith(
      {int? pageNum,
      List<Character>? loadedCharacter,
      CharacterStates? status,
      bool? hasMore,
      String? errorMessage}) {
    return CharacterState(
        pageNum: pageNum ?? this.pageNum,
        status: status ?? this.status,
        loadedCharacter: loadedCharacter ?? this.loadedCharacter,
        hasMore: hasMore ?? this.hasMore,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
