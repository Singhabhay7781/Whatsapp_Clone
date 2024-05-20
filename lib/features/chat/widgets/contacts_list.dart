import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_ui/features/chat/screens/mobile_chat_screen.dart';
import 'package:whatsapp_ui/models/chat_contact.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: StreamBuilder<List<ChatContact>>(
          stream: ref.read(chatControllerProvider).getChatContact(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text("No chats available! Start Messaging",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var chatContactData = snapshot.data![index];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              var name = chatContactData.name;
                              // var uid = chatContactData.contactId;
                              Navigator.pushNamed(
                                context,
                                MobileChatScreen.routeName,
                                arguments: {
                                  'name': name,
                                  'uid': chatContactData.contactId,
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(chatContactData.profilePic),
                                ),
                                title: Text(
                                  chatContactData.name,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    chatContactData.lastMessage,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                trailing: Text(
                                  DateFormat.Hm()
                                      .format(chatContactData.timeSent),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
          }),
    );
  }
}
