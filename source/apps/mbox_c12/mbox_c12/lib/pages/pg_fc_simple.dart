import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mbox_c12/controls/ctrl_app_end_drawer.dart';
import 'package:mbox_c12/themes/theme_selector.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart' show rootBundle;

class PgFcSimpleWidget extends StatefulWidget {
  const PgFcSimpleWidget({super.key});

  static String routeName = 'pg_flashcards_simple';
  static String routePath = '/PgFlashcards';

  @override
  State<PgFcSimpleWidget> createState() =>
      _PgFcSimpleWidgetState();
}

class BtnFlashcard extends StatelessWidget {
  const BtnFlashcard({super.key, required this.question, this.answer}); // Make answer optional
  final String question;
  final String? answer; // Nullable answer
  @override
  Widget build(BuildContext ctx) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
          ),
          child: Column( // Use a Column to stack question and answer
            mainAxisSize: MainAxisSize.min, // Fit content
            children: [
              Text(question),
              if (answer != null && answer!.isNotEmpty) ...[ // Show answer if available and not empty
                const SizedBox(height: 8.0),
                Text(
                  answer!,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
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
  Widget build(BuildContext ctx) {
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

class TblScoreBoard extends StatefulWidget {
  const TblScoreBoard({
    super.key,
    required this.wrong,
    required this.correct,
    required this.total,
    required this.score,
  });

  final int wrong;
  final int correct;
  final int total;
  final String score;

  @override
  State<TblScoreBoard> createState() => _TblScoreBoardState();
}

class _TblScoreBoardState extends State<TblScoreBoard> {
  @override
  Widget build(BuildContext ctx) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
        children: <Widget>[
          SizedBox(
            height: 37.0,
            child: Row(
              children: <Widget>[
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Total:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey, // You can customize the color
                  thickness: 1.0,    // You can customize the thickness
                  width: 20.0,       // Adjust the total width occupied by the divider
                ),
                Expanded(
                  flex: 3,
                  child: Text('${widget.total}'),
                ),
              ],
            ),
          ),
          Container(
            height: 37.0,
            color: Colors.red.withAlpha(100),
            child: Row(
              children: <Widget>[
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Wrong:',
                    style: TextStyle(fontWeight: FontWeight.bold),                  
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey, // You can customize the color
                  thickness: 1.0,    // You can customize the thickness
                  width: 20.0,       // Adjust the total width occupied by the divider
                ),
                Expanded(
                  flex: 3,
                  child: Text('${widget.wrong}'),
                ),
              ],
            ),
          ),          
          Container(
            height: 37.0,
            color: Colors.green.withAlpha(100),
            child : Row(
              children: <Widget>[
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Correct:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey, // You can customize the color
                  thickness: 1.0,    // You can customize the thickness
                  width: 20.0,       // Adjust the total width occupied by the divider
                ),
                Expanded(
                  flex: 3,
                  child: Text('${widget.correct}'),
                ),
              ],
            ),
          ),          
          SizedBox (
            height: 37.0,
            child: Row(
            children: <Widget>[
              const Expanded(
                flex: 3,
                child: Text(
                  'Score:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const VerticalDivider(
                color: Colors.grey, // You can customize the color
                thickness: 1.0,    // You can customize the thickness
                width: 20.0,       // Adjust the total width occupied by the divider
              ),
              Expanded(
                flex: 3,
                child: Text('${widget.score}'),
              ),
            ]),
          ),          
        ],
      ),
    );
  }
}

class _PgFcSimpleWidgetState extends State<PgFcSimpleWidget> {
  bool _isDataLoaded = false;
  int _currentIndex = 0;
  bool _showAnswer = false;
  bool _isResultButtonsGlowing = false;
  bool _isCardFlipped = false;
  int _totalCount = 0;
  int _correctCount = 0;
  int _incorrectCount = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _flashcardsData = [];

  @override
  void initState() {
    super.initState();
    _parseJsonData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _parseJsonData() async {
    try {
      final String jsonString = await rootBundle.loadString('lib/assets/vocabularies.json');
      final parsedData = jsonDecode(jsonString) as List<dynamic>;
      _flashcardsData = parsedData.cast<Map<String, dynamic>>();
      print('Flashcard Data: $_flashcardsData');
    } catch (e) {
      print('Error loading JSON: $e');
    }
    finally{
      setState(() {
        _isDataLoaded = true;
    });
    }
  }

  void _flipCard() {
    setState(() {
      _showAnswer = !_showAnswer; // Toggle the answer visibility
      _isCardFlipped = true;      // Indicate that the card has been flipped
      _isResultButtonsGlowing = true; // Enable result buttons
    });
  }

  void _markCorrect() {
    setState(() {
      _totalCount++;
      _correctCount++;
      _showAnswer = false;
      _isCardFlipped = false;  
      _isResultButtonsGlowing = false;
      _currentIndex = (_currentIndex + 1) % _flashcardsData.length;
    });
  }

  void _markIncorrect() {
    setState(() {
      _totalCount++;
      _incorrectCount++;
      _showAnswer = false;
      _isCardFlipped = false;  
      _isResultButtonsGlowing = false;
      _currentIndex = (_currentIndex + 1) % _flashcardsData.length;
    });
  }

  String get _averagePercentage =>
      _totalCount == 0 ? '0%' : '${((_correctCount / _totalCount) * 100).toStringAsFixed(0)}%';

  @override
  Widget build(BuildContext ctx) {
    final themeSelector = context.watch<ThemeSelector>();
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(ctx).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: themeSelector.currentTheme.primaryColorLight,
        appBar: AppBar(
          backgroundColor: themeSelector.currentTheme.primaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'C1/C2 Vocabularies Quiz',
            style: themeSelector.currentTheme.textTheme.titleSmall?.copyWith(color: Colors.white),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2,
        ),
        endDrawer: const CtrlAppEndDrawer(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              if (!_isDataLoaded)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (_flashcardsData.isNotEmpty)
                ...[
                  const SizedBox(height: 10),
                  BtnFlashcard(
                    question: _flashcardsData[_currentIndex]['question'],
                    answer: _isCardFlipped ? _flashcardsData[_currentIndex]['answer'] : null,
                  ),
                  const SizedBox(height: 10),
                  if (!_isCardFlipped)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _flipCard,
                          child: const Text('Flip the Card'),
                        ),
                      ),
                    ),
                  if(_isCardFlipped)
                    Row(
                      children: <Widget>[
                        BtnAction(
                          text: 'Correct',
                          color: Theme.of(ctx).colorScheme.secondary,
                          onPressed: _isResultButtonsGlowing ? _markCorrect : null,
                          isGlowing: _isResultButtonsGlowing,
                        ),
                        BtnAction(
                          text: 'Wrong',
                          color: Theme.of(ctx).colorScheme.error,
                          onPressed: _isResultButtonsGlowing ? _markIncorrect : null,
                          isGlowing: _isResultButtonsGlowing,
                        ),
                      ],
                    ),     
                  TblScoreBoard(wrong: _incorrectCount, correct: _correctCount, total: _totalCount, score: _averagePercentage)             
                ],
            ],
          ),
        ),
      ),
    );
  }
}