import 'dart:io';

import 'package:appiva_task/main.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:appiva_task/pages/logs_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LoginState {
  idle,
  verifying,
  gettingLocation,
  gettingPicture,
  uploadingPicture,
  uploadingData,
  error,
}

const List<String> loginStateTexts = [
  "Login",
  "Verifying Credentials",
  "Fetching Location",
  "Clicking Picture",
  "Uploading Picture",
  "Uploading Auth Data",
  "Error"
];

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
  late final CameraController _camController;

  LoginState _loginState = LoginState.idle;

  @override
  void initState() {
    super.initState();

    // Calling here so that geolocator gets properly initialized.
    getLocation();

    _camController = CameraController(
      cameras[1],
      ResolutionPreset.low,
    );
    
    _camController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _camController.dispose();
    super.dispose();
  }

  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> tryLogin() async {
    setState(() {
      _loginState = LoginState.verifying;
    });

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )
          .then(
        (creds) async {
          setState(() {
            _loginState = LoginState.gettingLocation;
          });
          final location = await getLocation();

          setState(() {
            _loginState = LoginState.gettingPicture;
          });
          final image = await _camController.takePicture();
          final time = DateTime.now();

          setState(() {
            _loginState = LoginState.uploadingPicture;
          });

          if (kIsWeb) {
            await FirebaseStorage.instance
                .ref('/images/${time.millisecondsSinceEpoch}')
                .putBlob(image);
          } else {
            await image.saveTo("${Directory.systemTemp.path}/img.jpg");

            await FirebaseStorage.instance
                .ref('/images/${time.millisecondsSinceEpoch}')
                .putFile(File("${Directory.systemTemp.path}/img.jpg"));
          }

          setState(() {
            _loginState = LoginState.uploadingData;
          });

          await FirebaseFirestore.instance.collection('/logs').add({
            "lat": location.latitude,
            "lon": location.longitude,
            "time": time,
          });
        },
        onError: (err) {
          throw err;
        },
      );
    } catch (err) {
      // print(err);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (await tryLogin()) {
                    Navigator.pushReplacementNamed(
                      context,
                      LogsPage.routeName,
                    );
                  }

                  setState(() {
                    _loginState = LoginState.idle;
                  });
                },
                child: _loginState == LoginState.idle
                    ? const Text(
                        "Login",
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            loginStateTexts[_loginState.index],
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
