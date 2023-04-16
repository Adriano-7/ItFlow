import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:itflowapp/main.dart';
import 'package:itflowapp/widgets/double_button.dart';
import 'package:itflowapp/controllers/register_controller.dart';

class RegisterForm extends StatefulWidget {
  final RegisterFormController _controller;
  const RegisterForm({Key? key, required RegisterFormController controller})
      : _controller = controller,
        super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;
  bool _isRepeatPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          DoubleButton(
            onPressedFirst: () {
              widget._controller.userType = UserType.standard;
            },
            onPressedSecond: () {
              widget._controller.userType = UserType.enterprise;
            },
            childFirst: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text('Standard'),
            ),
            childSecond: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text('Enterprise'),
            ),
          ),
          const SizedBox(height: 32),
          TextFormField(
            validator: widget._controller.usernameValidator,
            controller: widget._controller.nameController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person_outline),
              labelText: 'Name',
              hintText: 'John Goldman',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: widget._controller.emailValidator,
            controller: widget._controller.emailController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email_outlined),
              labelText: 'Email',
              hintText: 'example@gmail.com',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: widget._controller.phoneNumberValidator,
            controller: widget._controller.phoneController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.phone),
              labelText: 'Phone No.',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: widget._controller.passwordValidator,
            controller: widget._controller.passwordController,
            obscureText: _isPasswordHidden,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.key),
              labelText: 'Password',
              hintText: 'yourpassword',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.zero,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordHidden = !_isPasswordHidden;
                  });
                },
                icon: Icon(_isPasswordHidden
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextFormField(
              validator: widget._controller.repeatPasswordValidator,
              controller: widget._controller.repeatPasswordController,
              obscureText: _isRepeatPasswordHidden,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.key),
                labelText: 'Repeat Password',
                hintText: 'yourpassword',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.zero,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isRepeatPasswordHidden = !_isRepeatPasswordHidden;
                    });
                  },
                  icon: Icon(_isRepeatPasswordHidden
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, Routes.login);
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            // Full width button
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                if (widget._controller.userType == UserType.standard) {
                  widget._controller.screen = RegisterScreenType.standard;
                } else {
                  widget._controller.screen = RegisterScreenType.enterprise;
                }
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
