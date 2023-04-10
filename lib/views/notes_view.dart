import 'package:flutter/material.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_service.dart';

import '../constants/routes.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      leading: const Icon(Icons.note_alt),
      title: const Text("Notes"),
      actions: [
        PopupMenuButton<MenuItem>(
          onSelected: (value) async {
            switch (value) {
              case MenuItem.logout:
                final showLogOut = await showLogoutDialog(context);
                if (showLogOut) {
                  await AuthService.firebase().logOut();

                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  }
                }
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem<MenuItem>(
                value: MenuItem.logout,
                child: Text("Log out"),
              ),
            ];
          },
        )
      ],
    ));
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Log out"),
        content: const Text("Are you sure you want to log out?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Log out'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
