import 'package:flutter/material.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/widgets/MyButton.dart';
import 'package:itflowapp/constants.dart';
import 'package:itflowapp/main.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(appName),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
                flex: 4,
                child: Column(
                  children: const [
                    Image(image: AssetImage('assets/images/start_img.png')),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
                    Row(
                      children: [
                        Expanded(
                          child: MyButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.login);
                            },
                            leftRadius: 15,
                            backgroundColor: AppColors.green,
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                            verticalPadding: 16,
                            textContent: 'Log In',
                          ),
                        ),
                        Expanded(
                          child: MyButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.register);
                            },
                            rightRadius: 15,
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.green,
                            ),
                            verticalPadding: 16,
                            textContent: 'Register',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Not a fan of registering? Enter as a guest instead.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
