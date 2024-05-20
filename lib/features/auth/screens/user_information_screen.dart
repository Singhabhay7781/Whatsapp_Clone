import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information';
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final nameController = TextEditingController();
  File? image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage(BuildContext context) async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void saveUserData() {
    String name = nameController.text.trim();

    if (name.isEmpty) {
      showSnackBar(
        context: context,
        content: 'Please enter the valid name.',
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });
    ref.read(authControllerProvider).saveUserDataToFirebase(
          context,
          name,
          image,
        );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  image == null
                      ? const CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg',
                          ),
                          radius: 70,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 70,
                        ),
                  Positioned(
                    bottom: 5,
                    right: 15,
                    child: IconButton(
                      onPressed: () {
                        selectImage(context);
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: tabColor,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                  ),
                  _isLoading == true
                      ? const CircularProgressIndicator()
                      : IconButton(
                          onPressed: saveUserData,
                          icon: const Icon(Icons.done),
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
