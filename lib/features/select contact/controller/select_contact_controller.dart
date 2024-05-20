import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/features/select%20contact/repository/select_contact_repository.dart';

final getContactProvider = FutureProvider(
  (ref) {
    return ref.watch(selectContactRepositryProvider).getContacts();
  },
);

final selectContactControllerProvider = Provider((ref) {
  final selectContactRepositry = ref.watch(selectContactRepositryProvider);
  return SelectContactController(
      ref: ref, selectContactRepositry: selectContactRepositry);
});

class SelectContactController {
  final ProviderRef ref;
  final SelectContactRepositry selectContactRepositry;
  SelectContactController({
    required this.ref,
    required this.selectContactRepositry,
  });

  void selectContact(Contact selectedContact, BuildContext context) {
    selectContactRepositry.selectContact(selectedContact, context);
  }
}
