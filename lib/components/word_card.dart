import 'package:flutter/material.dart';

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
