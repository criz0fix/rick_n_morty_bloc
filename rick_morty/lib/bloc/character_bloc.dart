import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:rick_morty/models/character.dart';

import 'package:rick_morty/services/characters_api.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(const CharacterState()) {
    on<CharacterLoadEvent>(_loadList);
    on<CharacterClearEvent>(_clearList);
    on<CharacterNextPage>(_nextPage);
    on<CharacterPreviousPage>(_previousPage);
    //  on<CharacterNextPage>((event, Emitter<CharacterLoaded> emit) => {});
  }

  Future<void> _loadList(
    CharacterLoadEvent event,
    Emitter<CharacterState> emit,
  ) async {
    emit(state.copyWith(pageNum: state.pageNum));
    try {
      //final newList = state.loadedCharacter;
      await CharacterApi()
          .requestCharacters(
        state.pageNum,
      )
          .then(
        (listCharacter) {
          if (_notReached(state.pageNum)) {
            emit(
              state.copyWith(
                  loadedCharacter: [...state.loadedCharacter, ...listCharacter],
                  status: CharacterStates.loaded,
                  pageNum: state.pageNum + 1),
            );
          } else {
            emit(state.copyWith(hasMore: false));
          }
        },
      );
      // if (!_notReached(state.pageNum)) {
      //   pgControl.appendLastPage(state.loadedCharacter);
      // } else {
      //   final nextPageKey = state.pageNum + state.loadedCharacter.length;
      //   pgControl.appendPage(state.loadedCharacter, nextPageKey);
      // }
    } catch (e) {
      emit(state.copyWith(
          status: CharacterStates.error, errorMessage: e.toString()));
    }
  }

  void _clearList(CharacterClearEvent event, Emitter<CharacterState> emit) =>
      emit(state.copyWith(status: CharacterStates.initial, pageNum: 1));

  void _nextPage(CharacterNextPage event, Emitter<CharacterState> emit) {
    if (_notReached(state.pageNum)) {
      emit(state.copyWith(
          pageNum: state.pageNum + 1, status: CharacterStates.loading));
    } else {
      emit(state.copyWith(pageNum: 42));
    }
  }

  void _previousPage(
      CharacterPreviousPage event, Emitter<CharacterState> emit) {
    if (_notReached(state.pageNum)) {
      log('da');
      emit(state.copyWith(
          pageNum: state.pageNum - 1, status: CharacterStates.loading));
    } else {
      emit(state.copyWith(pageNum: 1));
    }
  }

  bool _notReached(int pageNum) {
    if (pageNum > 0 && pageNum < 42) {
      return true;
    }
    return false;
  }
}

// Future<void> getList() async {
  //   _changeState(ProviderStates.loading);
  //   await CharacterApi().requestCharacters().then((data) {
  //     characterList = data;
  //     _changeState(ProviderStates.loaded);
  //   }).catchError((e) {
  //     errorMessage = e.toString();
  //     _changeState(ProviderStates.error);
  //   });
  // }


// final nextPageKey = pageKey + newItems.length;
//         _pagingController.appendPage(newItems, nextPageKey);