import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app_state.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Container(
      color: const Color.fromARGB(255, 242, 162, 244),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Generated Words History',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    appState.clearHistory();
                  },
                  child: Text("Clear All"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ...appState.history.map(
                  (word) => ListTile(
                    title: Text(word.asLowerCase),
                    textColor: Theme.of(context).primaryColor,
                    onTap: () {
                      final snackBar = SnackBar(
                        content: Text("${word.asLowerCase}!"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    onLongPress: () {
                      appState.removeHistory(word);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
