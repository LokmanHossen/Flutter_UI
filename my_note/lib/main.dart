import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_note/Views/login_view.dart';
import 'package:my_note/Views/register_view.dart';

import 'firebase_options.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            //   final user = FirebaseAuth.instance.currentUser;
            //   if (user?.emailVerified ?? false) {
            //     return Text("Done");

            //     //print('You are verified user');
            //   } else {
            //     return const VerifyEnmailView();
            //     // print('You need to verify your Email first');
            //     // Navigator.of(context).push(
            //     //   MaterialPageRoute(
            //     //     builder: (context) => const VerifyEnmailView(),
            //     //   ),
            //     // );
            //   }
            return const LoginView();

          // print(FirebaseAuth.instance.currentUser);

          default:
            return const Text('Loading...');
        }
      },
    );
  }
}

class VerifyEnmailView extends StatefulWidget {
  const VerifyEnmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEnmailView> createState() => _VerifyEnmailViewState();
}

class _VerifyEnmailViewState extends State<VerifyEnmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Please Verify your email address'),
        TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text('Send Email verification'),
        ),
      ],
    );
  }
}
