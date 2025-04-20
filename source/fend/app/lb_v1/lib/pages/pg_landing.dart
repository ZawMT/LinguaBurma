import 'package:flutter/material.dart';
import 'package:lb_v1/pages/pg_signin.dart';
import 'package:lb_v1/providers/pv_userinfo.dart';
import 'package:provider/provider.dart';

class PgLanding extends StatelessWidget {
  const PgLanding({super.key});

  @override
  Widget build(BuildContext context) {
    final pvUserInfo = Provider.of<PVUserInfo>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lingua Burma'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${pvUserInfo.username}!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the login screen and replace the current route
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PGSignIn()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}