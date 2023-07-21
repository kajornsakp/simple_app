import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:simple_app/components/word_card.dart';
import 'package:simple_app/screens/card_screen.dart';
import 'package:simple_app/screens/favorite_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        primaryTextTheme: GoogleFonts.aBeeZeeTextTheme(
          Theme.of(context).textTheme,
        ),
        fontFamily: GoogleFonts.kanit().fontFamily,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WordPair word = WordPair.random();
  int _currentIndex = 0;
  Set<WordPair> favorites = {};

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_currentIndex) {
      case 0:
        page = buildCardPage();
        break;
      case 1:
        page = buildFavoritePage();
        break;
      case 2:
        page = buildPhotoPage();
        break;
      default:
        page = const Text("Error");
        break;
    }

    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width < 600
          ? BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setIndex(index),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: "Favorite"),
                BottomNavigationBarItem(icon: Icon(Icons.photo), label: "Photo")
              ],
            )
          : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 600)
            NavigationRail(
                extended: MediaQuery.of(context).size.width > 640,
                destinations: const [
                  NavigationRailDestination(
                      icon: Icon(Icons.home), label: Text("Home")),
                  NavigationRailDestination(
                      icon: Icon(Icons.favorite), label: Text("Favorite")),
                ],
                selectedIndex: _currentIndex,
                onDestinationSelected: (index) => setIndex(index)),
          Expanded(
            child: Center(child: page),
          ),
        ],
      ),
    );
  }

  Widget buildPhotoPage() {
    return Image.asset("assets/image_1.jpeg");
  }

  Widget buildFavoritePage() {
    return FavoritePage(favorites: favorites);
  }

  Widget buildCardPage() {
    return CardPage(
        word: word,
        isFavorite: favorites.contains(word),
        onFavoriteTapped: (word) {
          setState(() {
            if (favorites.contains(word)) {
              favorites.remove(word);
            } else {
              favorites.add(word);
            }
          });
        },
        onRandomizeTapped: () {
          setState(() {
            word = WordPair.random();
          });
        });
  }

  void setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
