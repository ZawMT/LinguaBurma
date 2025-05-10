import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lb_v1/pages/pg_flashcards_simple.dart';

class PgFlashcardsSettingsWidget extends StatefulWidget {
  const PgFlashcardsSettingsWidget({super.key});

  static String routeName = 'pg_flashcards_intro';
  static String routePath = '/PgFlashcardsSettings';

  @override
  State<PgFlashcardsSettingsWidget> createState() =>
      _PgFlashcardsSettingsWidgetState();
}

class _PgFlashcardsSettingsWidgetState extends State<PgFlashcardsSettingsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final Color primaryColor = Colors.blue;
  final Color primaryBackgroundColor = Colors.white; 
  TextStyle headlineMediumTextStyle(BuildContext context) =>
      GoogleFonts.interTight(
        fontSize: 22,
        fontWeight: FontWeight.w700, 
        color: Colors.white,
        letterSpacing: 0.0,
        fontStyle: FontStyle.normal, 
      );
  TextStyle titleSmallTextStyle(BuildContext context) => GoogleFonts.interTight(
        fontWeight: FontWeight.w500, 
        color: Colors.white,
        letterSpacing: 0.0,
        fontStyle: FontStyle.normal, 
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Flashcards Settings',
            style: headlineMediumTextStyle(context),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const PgFlashcardsSimpleWidget()),
                    );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 40), // Match height
                ),
                child: Text(
                  'Simple Mode',
                  style: titleSmallTextStyle(context),
                ),
              ),
              const SizedBox(height: 16), // Add some spacing between buttons
              ElevatedButton(
                onPressed: () {
                  print('Button pressed ...');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 40), // Match height
                ),
                child: Text(
                  'Extra Mode',
                  style: titleSmallTextStyle(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}