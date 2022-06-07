part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class CharacterLoadEvent extends CharacterEvent {}

class CharacterClearEvent extends CharacterEvent {}

class CharacterNextPage extends CharacterEvent {}

class CharacterPreviousPage extends CharacterEvent {}
