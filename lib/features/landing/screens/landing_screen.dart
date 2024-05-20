import 'package:flutter/material.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/widgets/custom_button.dart';
import 'package:whatsapp_ui/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Welcome to WhatsApp',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height / 20),
            Image.asset(
              'assets/bg.png',
              height: 340,
              width: 340,
              color: tabColor,
            ),
            SizedBox(height: size.height / 12),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Read our Privacy Policy. Tap \'Agree and continue\' to accept the Terms of Services.',
                style: TextStyle(
                  color: greyColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: 'AGREE AND CONTINUE',
                onPressed: () => navigateToLoginScreen(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
