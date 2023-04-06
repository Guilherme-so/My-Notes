import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _HomePageState();
}

class _HomePageState extends State<RegisterView> {
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
      appBar: AppBar(
        title: const Text('Register'),
      ),
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
                child: const Text('Register'),
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;

                  try {
                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password);

                    print(userCredential);
                  } on FirebaseAuthException catch (e) {
                    // print(e.code);
                    // print(e.message);
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == "invalid-email") {
                      print('Invalid email');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login/',
                    (route) => false,
                  );
                },
                child: const Text("Already registered? login here!"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
