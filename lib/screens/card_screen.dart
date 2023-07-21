import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/components/word_card.dart';

class CardPage extends StatelessWidget {
  const CardPage(
      {super.key,
      required this.word,
      required this.onFavoriteTapped,
      required this.onRandomizeTapped,
      this.isFavorite = false});

  final bool isFavorite;
  final WordPair word;
  final Function(WordPair) onFavoriteTapped;
  final VoidCallback onRandomizeTapped;

  @override
  Widget build(BuildContext context) {
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
                  onFavoriteTapped(word);
                },
                child: this.isFavorite
                    ? const Text("Added")
                    : const Text("Favorite")),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: () {
                  onRandomizeTapped();
                },
                child: const Text("Randomize")),
          ],
        ),
      ],
    );
  }
}
