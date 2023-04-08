import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/register_view.dart';

import '../constants/routes.dart';
import '../utilities/show_erro_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _HomePageState();
}

class _HomePageState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool verSenha = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 8.0, 22, 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _email,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Put your email here",
                ),
              ),
              TextField(
                controller: _password,
                obscureText: verSenha,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  hintText: "Put your password here",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        verSenha = !verSenha;
                      });
                    },
                    icon: const Icon(Icons.remove_red_eye_sharp),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                child: const Text('Login'),
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;

                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email, password: password);

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute,
                      (route) => false,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      await showErrorDialog(
                        context,
                        'No user found.',
                      );
                    } else if (e.code == 'wrong-password') {
                      await showErrorDialog(
                        context,
                        'Wrong credentials.',
                      );
                    } else {
                      await showErrorDialog(
                        context,
                        'Error: ${e.code}.',
                      );
                    }
                  } catch (e) {
                    await showErrorDialog(
                      context,
                      e.toString(),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                },
                child: const Text("Not registered yet? register here!"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
