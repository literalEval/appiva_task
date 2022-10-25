import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:appiva_task/pages/logs_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  static const routeName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Calling here so that geolocator gets properly initialized.
    getLocation();
  }

  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
            ),
            TextFormField(
              controller: _passwordController,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                )
                    .then(
                  (creds) async {
                    final location = await getLocation();

                    FirebaseFirestore.instance.collection('/logs').add({
                      "lat": location.latitude,
                      "lon": location.longitude,
                      "time": DateTime.now(),
                    }).then(
                      (value) => Navigator.pushReplacementNamed(
                        context,
                        LogsPage.routeName,
                      ),
                    );
                  },
                  onError: (err) {
                    print(err);
                  },
                );
              },
              child: const Text(
                "Login",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
