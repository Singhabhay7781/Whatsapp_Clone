import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/common/widgets/custom_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routName = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  bool _isLoading = false;

  Country? _country;
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      favorite: ['IN'],
      onSelect: (Country country) {
        setState(() {
          _country = country;
        });
      },
    );
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (_country != null && phoneNumber.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      ref.read(authControllerProvider).signInWithPhone(
            context,
            '+${_country!.phoneCode}$phoneNumber',
          );
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Enter your phone number',
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Whatsapp will need to verify your mobile number.',
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: pickCountry,
                child: const Text(
                  'Pick Country',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_country != null)
                    Text(
                      '+${_country!.phoneCode}',
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'phone number',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.22,
              ),
              if (_isLoading == false)
                SizedBox(
                  width: 90,
                  child: CustomButton(
                    onPressed: sendPhoneNumber,
                    text: 'NEXT',
                  ),
                )
              else
                const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
