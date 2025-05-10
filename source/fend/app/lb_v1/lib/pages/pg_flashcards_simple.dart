import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lb_v1/themes/theme_selector.dart';

class PgFlashcardsSimpleWidget extends StatefulWidget {
  const PgFlashcardsSimpleWidget({super.key});

  static String routeName = 'pg_flashcards_simple';
  static String routePath = '/pgFlashcardsSimple';

  @override
  State<PgFlashcardsSimpleWidget> createState() =>
      _PgFlashcardsSimpleWidgetState();
}

class BtnQuestion extends StatelessWidget {
  const BtnQuestion({super.key, required this.question});
  final String question;
  @override
  Widget build(BuildContext context) {
    return Expanded( // Wrap with Expanded
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
          ),
          child: Text(question),
        ),
      )
    );
  }
}

class BtnAnswer extends StatelessWidget {
  const BtnAnswer({super.key, required this.answer});
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Expanded( // Wrap with Expanded
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
          ),
          child: Text("Show Answer"),
        ),
      )
    );
  }
}

class BtnRight extends StatelessWidget {
  const BtnRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary
        ),
        child: const Text('Correct'),
      ),
    );
  }
}

class BtnWrong extends StatelessWidget {
  const BtnWrong({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.error
        ),
        child: const Text('Wrong'),
      ),
    );
  }
}

class BtnTotal extends StatelessWidget {
  const BtnTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ElevatedButton(onPressed: () {}, child: Text('Total')));
  }
}

class BtnTotalCnt extends StatelessWidget {
  const BtnTotalCnt({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ElevatedButton(onPressed: () {}, child: Text('0')));
  }
}

class BtnCorrect extends StatelessWidget {
  const BtnCorrect({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary
        ),
        child: const Text('Correct'),
      ),
    );
  }
}

class BtnCorrectCnt extends StatelessWidget {
  const BtnCorrectCnt({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary
        ),
        child: const Text('0'),
      ),
    );
  }
}

class BtnIncorrect extends StatelessWidget {
  const BtnIncorrect({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.error
        ),
        child: const Text('Wrong'),
      ),
    );
  }
}

class BtnIncorrectCnt extends StatelessWidget {
  const BtnIncorrectCnt({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.error
        ),
        child: const Text('0'),
      ),
    );
  }
}

class BtnAverage extends StatelessWidget {
  const BtnAverage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ElevatedButton(onPressed: () {}, child: Text('Average Score')));
  }
}

class BtnAveragePercent extends StatelessWidget {
  const BtnAveragePercent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ElevatedButton(onPressed: () {}, child: Text('0%')));
  }
}

class _PgFlashcardsSimpleWidgetState extends State<PgFlashcardsSimpleWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _flashcardsData = [];
  // Hardcoded JSON data
  final String _jsonFlashcards = '''
    [
      {
        "question": "cynical",
        "answer": "believing that people only do things to help themselves rather than for good or honest reasons"
      },
      {
        "question": "mammoth",
        "answer": "an animal like a large elephant covered with hair, that lived thousands of years ago and is now extinct"
      },
      {
        "question": "precipice",
        "answer": "a very steep side of a high cliff, mountain or rock"
      }
    ]
  ''';

  @override
  void initState() {
    super.initState();
    _parseJsonData(); 
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _parseJsonData() {
    final parsedData = jsonDecode(_jsonFlashcards) as List<dynamic>;
    _flashcardsData = parsedData.cast<Map<String, dynamic>>();
    // You can print it to verify the data is parsed correctly
    print('Flashcard Data: $_flashcardsData');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: ThemeSelector.currentTheme.primaryColorLight,
        appBar: AppBar(
          backgroundColor: ThemeSelector.currentTheme.primaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Simple Flashcards ',
            style: ThemeSelector.currentTheme.textTheme.titleSmall?.copyWith(
              color: Colors.white
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          child: Column(
          children: <Widget>[
            if (_flashcardsData.isNotEmpty)
              ...[
              const SizedBox(height: 10),
              BtnQuestion(question: _flashcardsData[0]['question']),
              const SizedBox(height: 10),
              BtnAnswer(answer: _flashcardsData[0]['answer']),
              const SizedBox(height: 10),
              Row(children: <Widget>[
                BtnRight(), BtnWrong()
              ],
              ),
              Row(children: <Widget>[
                BtnTotal(), BtnTotalCnt()
              ],
              ),
              Row(children: <Widget>[
                BtnCorrect(), BtnCorrectCnt()
              ],
              ),
              Row(children: <Widget>[
                BtnIncorrect(), BtnIncorrectCnt()
              ],
              ),
              Row(children: <Widget>[
                BtnAverage(), BtnAveragePercent()
              ],
              )]
          ],
        ),
        ),
      ),
    );
  }
}