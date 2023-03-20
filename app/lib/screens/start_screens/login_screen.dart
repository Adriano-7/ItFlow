import 'package:flutter/material.dart';
import 'package:itflowapp/constants.dart';
import 'package:itflowapp/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(appName),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nice to see you again!',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            "Let's get you signed in!",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: LoginForm())
                    ],
                  ),
                ))
          ],
        )

        //LoginForm(),
        );
  }
}
