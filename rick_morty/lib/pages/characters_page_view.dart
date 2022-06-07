//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/character_bloc.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final controller = ScrollController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        context.read<CharacterBloc>().add(CharacterLoadEvent());
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
      return ListView.builder(
        controller: controller,
        itemCount: state.loadedCharacter.length + 1,
        itemBuilder: ((context, index) {
          if (index < state.loadedCharacter.length) {
            final item = state.loadedCharacter[index];
            return Card(
              child: ListTile(
                title: Text(item.name),
                subtitle: Text(item.species),
                leading: Image.network(item.image),
              ),
            );
          } else if (state.hasMore) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const Center(
              child: Text("No more data"),
            );
          }
        }),
      );
    });

    // controller: ScrollController(),
    // itemCount: state.loadedCharacter.length,
    // itemBuilder: ((context, index) {
    //   final item = state.loadedCharacter[index];
    //   return Card(
    //     child: ListTile(
    //       title: Text(item.name),
    //       subtitle: Text(item.species),
    //       leading: Image.network(item.image),
    //     ),
    //   );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
