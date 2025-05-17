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
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
          ),
          child: Text(question),
        ),
      ),
    );
  }
}

class BtnAnswer extends StatefulWidget {
  const BtnAnswer({
    super.key,
    required this.answer,
    required this.glowColor,
    required this.showAnswer,
    required this.onTap,
    required this.isGlowing,
  });

  final String answer;
  final Color glowColor;    
  final bool showAnswer;
  final VoidCallback onTap;
  final bool isGlowing;

  @override
  State<BtnAnswer> createState() => _BtnAnswerState();
}

class _BtnAnswerState extends State<BtnAnswer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            boxShadow: widget.isGlowing
              ? [
                  BoxShadow(
                    color: widget.glowColor.withAlpha(150), 
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                  BoxShadow(
                    color: widget.glowColor.withAlpha(120),
                    spreadRadius: 3,
                    blurRadius: 8,
                    offset: const Offset(0, 0),
                  ),
                ]
              : [],
          ),
          child: ElevatedButton(
            onPressed: widget.onTap,
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
            ),
            child: Text(widget.showAnswer ? widget.answer : "Show Answer"),
          ),
        ),
      ),
    );
  }
}

class BtnAction extends StatefulWidget {
  const BtnAction({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    required this.isGlowing,
  });

  final String text;
  final Color color;
  final VoidCallback? onPressed; // Make onPressed nullable
  final bool isGlowing;

  @override
  State<BtnAction> createState() => _BtnActionState();
}

class _BtnActionState extends State<BtnAction> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: widget.isGlowing
              ? [
                  BoxShadow(
                    color: widget.color.withAlpha(150),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ]
              : [],
        ),
        child: ElevatedButton(
          onPressed: widget.onPressed, // onPressed is now nullable here as well
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

class BtnTotal extends StatelessWidget {
  const BtnTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: ElevatedButton(onPressed: null, child: Text('Total')));
  }
}

class BtnTotalCnt extends StatelessWidget {
  const BtnTotalCnt({super.key, required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ElevatedButton(onPressed: null, child: Text('$count')));
  }
}

class BtnCorrect extends StatelessWidget {
  const BtnCorrect({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        child: const Text('Correct'),
      ),
    );
  }
}

class BtnCorrectCnt extends StatelessWidget {
  const BtnCorrectCnt({super.key, required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        child: Text('$count'),
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
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
        child: const Text('Wrong'),
      ),
    );
  }
}

class BtnIncorrectCnt extends StatelessWidget {
  const BtnIncorrectCnt({super.key, required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
        child: Text('$count'),
      ),
    );
  }
}

class BtnAverage extends StatelessWidget {
  const BtnAverage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: ElevatedButton(onPressed: null, child: Text('Average Score')));
  }
}

class BtnAveragePercent extends StatelessWidget {
  const BtnAveragePercent({super.key, required this.percentage});
  final String percentage;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ElevatedButton(onPressed: null, child: Text(percentage)));
  }
}

class _PgFlashcardsSimpleWidgetState extends State<PgFlashcardsSimpleWidget> {
  int _currentIndex = 0;
  bool _showAnswer = false;
  bool _isAnswerButtonGlowing = true;
  bool _isResultButtonsGlowing = false;
  int _totalCount = 0;
  int _correctCount = 0;
  int _incorrectCount = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _flashcardsData = [];
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
    print('Flashcard Data: $_flashcardsData');
  }

  void _showAnswerAndEnableResult() {
    setState(() {
      _showAnswer = true;
      _isAnswerButtonGlowing = false;
      _isResultButtonsGlowing = true;
    });
  }

  void _markCorrect() {
    setState(() {
      _totalCount++;
      _correctCount++;
      _showAnswer = false;
      _isAnswerButtonGlowing = true;
      _isResultButtonsGlowing = false;
      _currentIndex = (_currentIndex + 1) % _flashcardsData.length;
    });
  }

  void _markIncorrect() {
    setState(() {
      _totalCount++;
      _incorrectCount++;
      _showAnswer = false;
      _isAnswerButtonGlowing = true;
      _isResultButtonsGlowing = false;
      _currentIndex = (_currentIndex + 1) % _flashcardsData.length;
    });
  }

  String get _averagePercentage =>
      _totalCount == 0 ? '0%' : '${((_correctCount / _totalCount) * 100).toStringAsFixed(0)}%';

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
            style: ThemeSelector.currentTheme.textTheme.titleSmall?.copyWith(color: Colors.white),
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
                  BtnQuestion(question: _flashcardsData[_currentIndex]['question']),
                  const SizedBox(height: 10),
                  BtnAnswer(
                    answer: _flashcardsData[_currentIndex]['answer'],
                    glowColor: Theme.of(context).colorScheme.shadow,
                    showAnswer: _showAnswer,
                    onTap: _showAnswerAndEnableResult,
                    isGlowing: _isAnswerButtonGlowing,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      BtnAction(
                        text: 'Correct',
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: _isResultButtonsGlowing ? _markCorrect : null,
                        isGlowing: _isResultButtonsGlowing,
                      ),
                      BtnAction(
                        text: 'Wrong',
                        color: Theme.of(context).colorScheme.error,
                        onPressed: _isResultButtonsGlowing ? _markIncorrect : null,
                        isGlowing: _isResultButtonsGlowing,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const BtnTotal(),
                      BtnTotalCnt(count: _totalCount),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const BtnCorrect(),
                      BtnCorrectCnt(count: _correctCount),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const BtnIncorrect(),
                      BtnIncorrectCnt(count: _incorrectCount),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const BtnAverage(),
                      BtnAveragePercent(percentage: _averagePercentage),
                    ],
                  ),
                ],
            ],
          ),
        ),
      ),
    );
  }
}