import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/widgets/double_button.dart';
import 'package:itflowapp/constants.dart';
import 'package:itflowapp/main.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Image(
                        image: AssetImage('assets/images/start_img.png'))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text(
                    'Welcome to ItFlow',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Discover your dream job with all the right opportunities in one place.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                )
              ],
            )),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        recognizer: TapGestureRecognizer()..onTap = (){
                          // Remove Every Screen and Leave Only the New One
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.home, ModalRoute.withName('/'));
                        },
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                        )
                      ),
                      const TextSpan(
                        text: ' instead.'
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),);
  }
}
