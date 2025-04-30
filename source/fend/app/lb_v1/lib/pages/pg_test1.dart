import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PgTest1 extends StatefulWidget {
  const PgTest1({super.key});

  static String routeName = 'pgTest1';
  static String routePath = '/pgTest1';

  @override
  State<PgTest1> createState() => _PgTest1State();
}

class _PgTest1State extends State<PgTest1> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Test page',
            style: TextStyle(
              fontFamily: GoogleFonts.interTight().fontFamily,
              fontWeight: FontWeight.w500, // Example fontWeight
              fontStyle: FontStyle.normal,   // Example fontStyle
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 0.0,
            ),
          ),
          actions: const <Widget>[], // Using const for an empty list of actions
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromHeight(40),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'TestOne',
                      style: TextStyle(
                        fontFamily: 'Inter Tight', // Using the font family name directly
                        fontWeight: FontWeight.w500, // Example fontWeight
                        fontStyle: FontStyle.normal,   // Example fontStyle
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontSize: 14, // Example fontSize for button text
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}