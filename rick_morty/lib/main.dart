import 'package:flutter/material.dart';
import 'package:rick_morty/character_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CharacterProvider(
            state: ProviderStates.initialized, characterList: []),
        child: MaterialApp(
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Rick\'N Morty'),
              centerTitle: true,
            ),
            body: Consumer<CharacterProvider>(
              builder: (context, provider, child) {
                if (provider.state == ProviderStates.initialized) {
                  return Center(
                    child: ElevatedButton(
                        onPressed: () => provider.getList(),
                        child: const Text("Load page")),
                  );
                } else if (provider.state == ProviderStates.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (provider.state == ProviderStates.loaded) {
                  return ListView.builder(
                      itemCount: provider.characterList.length,
                      itemBuilder: ((context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(provider.characterList[index].name),
                            subtitle:
                                Text(provider.characterList[index].species),
                            leading: Image.network(
                                provider.characterList[index].image),
                          ),
                        );
                      }));
                } else {
                  return Center(
                    child: Text(provider.errorMessage),
                  );
                }
              },
            ),
          ),
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              CharacterProvider(
                  state: ProviderStates.initialized, characterList: []);
            },
            child: const Text('Load Api'),
          ),
        ),
      ],
    );
  }
}
