import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:google_fonts/google_fonts.dart';

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
        primaryColor: Colors.white,
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
    return ListView(
      children: favorites.map((e) => ListTile(title: Text(e.asPascalCase))).toList(),
    );
  }

  Widget buildCardPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WordCard(word: word.asPascalCase),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    favorites.contains(word)
                        ? favorites.remove(word)
                        : favorites.add(word);
                  });
                },
                child: favorites.contains(word)
                    ? const Text("Added")
                    : const Text("Favorite")),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    word = WordPair.random();
                  });
                },
                child: const Text("Randomize")),
          ],
        ),
      ],
    );
  }

  void setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    required this.word,
  });

  final String word;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child:
            Text(word, style: Theme.of(context).primaryTextTheme.displayMedium),
      ),
    );
  }
}
