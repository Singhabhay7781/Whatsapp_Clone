import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStoregeRepositoryProvider =
    Provider((ref) => CommonFirebaseStoregeRepository(
          firebseStroage: FirebaseStorage.instance,
        ));

class CommonFirebaseStoregeRepository {
  final FirebaseStorage firebseStroage;
  CommonFirebaseStoregeRepository({
    required this.firebseStroage,
  });
  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebseStroage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
