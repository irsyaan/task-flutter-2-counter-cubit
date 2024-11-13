import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wise_word_counter/app.dart';
import 'package:wise_word_counter/counter/counter.dart';
import 'package:wise_word_counter/counter_observer.dart';
import 'package:wise_word_counter/wiseword/my_app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'wiseword/favorites_page.dart';
import 'wiseword/generator_page.dart';
import 'wiseword/history_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Bloc.observer = const CounterObserver();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyAppState()),
        BlocProvider(create: (context) => CounterCubit())
      ],
      child: MaterialApp(
        title: 'Wise Word and Counter App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        ),
        home: const MainPage(),
        debugShowCheckedModeBanner: false,  // Ensure this is set
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    CounterPage(), // Ensure CounterPage is properly used here
    GeneratorPage(),
    FavoritesPage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.calculate),
            icon: Icon(Icons.calculate_outlined),
            label: 'Counter',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.dynamic_feed),
            icon: Icon(Icons.dynamic_feed_outlined),
            label: 'Generator',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.history),
            icon: Icon(Icons.history_outlined),
            label: 'History',
          ),
        ],
      ),
      body: _pages[selectedIndex], // Ensure this part is correctly handling navigation
    );
  }
}
