import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/bloc/character_bloc.dart';

import 'pages/characters_page_view.dart';

// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

//import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => CharacterBloc(),
        child: Builder(builder: (context) {
          //final myBloc = context.read<CharacterBloc>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Rick\'N Morty'),
              centerTitle: true,
            ),
            body: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                if (state.status == CharacterStates.initial) {
                  return Center(
                    child: OutlinedButton(
                      child: const Text(
                        'Load Characters',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => context
                          .read<CharacterBloc>()
                          .add(CharacterLoadEvent()),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.purple.shade400)),
                    ),
                  );
                } else if (state.status == CharacterStates.loading) {
                  log('loading');
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == CharacterStates.loaded) {
                  log('loaded');
                  return const CharactersPage();
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.errorMessage),
                        OutlinedButton(
                          onPressed: () => context
                              .read<CharacterBloc>()
                              .add(CharacterLoadEvent()),
                          child: const Text(
                            'Try Again',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
