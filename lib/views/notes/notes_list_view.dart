import 'package:flutter/material.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';

import '../../utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(CloudNote note);

class NotesListVliew extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallback onDeleteNote;
  final NoteCallback onTap;

  const NotesListVliew({
    super.key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        return Dismissible(
          key: Key(note.documentId),
          onDismissed: (direction) {
            // / on swipe for any side, delete note
            onDeleteNote(note);
            //Snackbar on the botton with the note text
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Deleted : ${note.text}'),
              ),
            );
          },
          child: ListTile(
            onTap: () {
              onTap(note);
            },
            title: Text(
              note.text,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () async {
                final showDelete = await showDeleteDialog(context);
                if (showDelete) {
                  onDeleteNote(note);
                }
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        );
      },
      separatorBuilder: (context, _) => const Divider(),
    );
  }
}
