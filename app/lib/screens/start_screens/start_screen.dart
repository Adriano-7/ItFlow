import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/controllers/firebase/auth.dart';
import 'package:itflowapp/widgets/custom_widgets/double_button.dart';
import 'package:itflowapp/main.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Image(image: AssetImage(kStartImageAssetPath)),
            const SizedBox(height: 15),
            const Text(
              'Welcome to',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Hero(
              tag: kLogoHeroTag,
              child: Image.asset(kLogoImageAssetPath, height: 30),
            ),
            const SizedBox(height: 15),
            const Text(
              'Discover your dream job with all the right opportunities in one place.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 160),
            DoubleButton(
              onPressedFirst: () {
                Navigator.pushNamed(context, Routes.login);
              },
              childFirst: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Log In'),
              ),
              onPressedSecond: () {
                Navigator.pushNamed(context, Routes.register);
              },
              childSecond: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Register'),
              ),
            ),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(
                text: 'Not a fan of registering? Enter as a ',
                children: [
                  TextSpan(
                      text: 'guest',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          AuthController.isGuest = true;
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.home, ModalRoute.withName('/'));
                        },
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                      )),
                  const TextSpan(text: ' instead.')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
