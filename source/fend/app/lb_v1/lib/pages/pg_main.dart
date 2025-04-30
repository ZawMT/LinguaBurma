import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PgMain extends StatefulWidget {
  const PgMain({super.key});

  static const String routeName = 'pg_main';
  static const String routePath = '/pgMain';

  @override
  State<PgMain> createState() => _PgMainState();
}

class _PgMainState extends State<PgMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFF1F4F8), // FlutterFlowTheme.of(context).primaryBackground
        endDrawer: SizedBox(
          width: 180,
          child: Drawer(
            elevation: 16,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'About',
                      style: TextStyle(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.normal, // FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle: FontStyle.normal, // FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        fontSize: 14, // Default bodyMedium fontSize
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Exit',
                      style: TextStyle(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.normal, // FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle: FontStyle.normal, // FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        fontSize: 14, // Default bodyMedium fontSize
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF4B39EF), // FlutterFlowTheme.of(context).primary
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // context.pop() in FlutterFlow
            },
          ),
          title: Text(
            'Lingua Burma',
            style: TextStyle(
              fontFamily: GoogleFonts.interTight().fontFamily,
              fontWeight: FontWeight.w500, // FlutterFlowTheme.of(context).headlineMedium.fontWeight,
              fontStyle: FontStyle.normal, // FlutterFlowTheme.of(context).headlineMedium.fontStyle,
              color: Colors.white,
              fontSize: 23,
              letterSpacing: 0.0,
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding( // Flashcards button
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                child: ElevatedButton(
                  onPressed: () {
                    print('Flashcards button is pressed ...');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B39EF), // FlutterFlowTheme.of(context).primary
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 70), // Equivalent to height: 40
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max, // Adjust based on your layout needs
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'lib/images/Flashcards-64.png', // Replace with the actual name of your image file
                        height: 54, // Adjust the height as needed
                      ),
                      const SizedBox(width: 8), // Add some spacing between the image and text
                      Text(
                        'Flashcards',
                        style: TextStyle(
                          fontFamily: GoogleFonts.interTight().fontFamily,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 21,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  )
                ),
              ), // Flashcards button
              Padding( // Quotes button
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                child: ElevatedButton(
                  onPressed: () {
                    print('Quotes button is pressed ...');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B39EF), // FlutterFlowTheme.of(context).primary
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 70), // Equivalent to height: 40
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max, // Adjust based on your layout needs
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'lib/images/Quotes-64.png', // Replace with the actual name of your image file
                        height: 54, // Adjust the height as needed
                      ),
                      const SizedBox(width: 8), // Add some spacing between the image and text
                      Text(
                        'Quotes',
                        style: TextStyle(
                          fontFamily: GoogleFonts.interTight().fontFamily,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 21,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}