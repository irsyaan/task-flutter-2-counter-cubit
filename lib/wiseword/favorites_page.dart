import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app_state.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Container(
      color: const Color.fromARGB(255, 242, 162, 244),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'You have ${appState.favorites.length} favorite words.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ...appState.favorites.map(
            (word) => ListTile(
              title: Text(word.asLowerCase),
              textColor: Theme.of(context).primaryColor,
              onTap: () {
                final snackBar = SnackBar(
                  content: Text("It's ${word.asLowerCase}!"),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              onLongPress: () {
                appState.removeFavorite(word);
              },
            ),
          ),
        ],
      ),
    );
  }
}

