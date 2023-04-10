import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_service.dart';

import '../constants/routes.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify email"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "We have already sent you a email verifycation, Please open it to verify.",
            ),
            const Text(
              "If you haven't received it yet,press on the button bellow.",
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text("Send email"),
            ),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                }
              },
              child: const Text("Restart"),
            ),
          ],
        ),
      ),
    );
  }
}
