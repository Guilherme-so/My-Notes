class CouldStorageException implements Exception {
  const CouldStorageException();
}

class CouldNotCreateNoteException extends CouldStorageException {}

class CouldNotGetAllNotesException extends CouldStorageException {}

class CouldNotUpdateNoteException extends CouldStorageException {}

class CouldNotDeleteNoteException extends CouldStorageException {}
