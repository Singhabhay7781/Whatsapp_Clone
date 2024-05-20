import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/widgets/error.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/features/select%20contact/controller/select_contact_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const routeName = '/select-contacts-scree';
  const SelectContactsScreen({super.key});

  void selectContact(
      WidgetRef ref, BuildContext context, Contact selectedContact) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contact'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ref.watch(getContactProvider).when(
            data: (contactList) => ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                final contact = contactList[index];
                return InkWell(
                  onTap: () => selectContact(ref, context, contact),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      title: Text(
                        contact.displayName,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      leading: contact.photo == null
                          ? null
                          : CircleAvatar(
                              backgroundImage: MemoryImage(
                                contact.photo!,
                              ),
                              radius: 30,
                            ),
                    ),
                  ),
                );
              },
            ),
            error: (error, trace) => ErrorScreen(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
