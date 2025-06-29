import 'package:flutter/material.dart';
import 'package:mbox_c12/pages/pg_fc_simple.dart';

class PgLanding extends StatelessWidget {
  const PgLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MinBox: C1/C2 Vocabularies'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'C1/C2 Vocabularies',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PgFcSimpleWidget()),
                );
              },
              child: const Text('Learn'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const PgFcSimpleWidget()),
                    );
              },
              child: const Text('Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}