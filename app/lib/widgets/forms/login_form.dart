import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/controllers/login_controller.dart';
import 'package:itflowapp/main.dart';

class LoginForm extends StatefulWidget {
  bool _isPasswordHidden = true;
  final _controller = LoginFormController();

  LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: widget._controller.emailValidator,
            controller: widget._controller.emailController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person_outline),
              labelText: 'Email',
              hintText: 'example@gmail.com',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: const EdgeInsets.all(25.0),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            validator: widget._controller.passwordValidator,
            controller: widget._controller.passwordController,
            obscureText: widget._isPasswordHidden,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.key),
              labelText: 'Password',
              hintText: 'yourpassword',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: const EdgeInsets.all(25.0),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    widget._isPasswordHidden = !widget._isPasswordHidden;
                  });
                },
                icon: Icon(widget._isPasswordHidden
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                  value: widget._controller.rememberLogin,
                  onChanged: (value) {
                    setState(() {
                      widget._controller.rememberLogin = value!;
                    });
                  }),
              const SizedBox(width: 5),
              const Text("Remember Me"),
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, Routes.register);
                      },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            //full width button
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                widget._controller.submit().then((isAllGood) {
                  if (isAllGood) {
                    // Remove Every Screen and Leave Only the New One
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.home, ModalRoute.withName('/'));
                  } else {
                    setState(() {});
                  }
                });
              },
              child: const Text('Log In'),
            ),
          ),
          (widget._controller.errorMessage == null)
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      widget._controller.errorMessage!,
                      style: const TextStyle(color: AppColors.red),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
