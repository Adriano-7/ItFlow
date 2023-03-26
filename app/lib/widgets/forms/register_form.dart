import 'package:flutter/material.dart';
import 'package:itflowapp/controllers/auth.dart';
import 'package:itflowapp/main.dart';

class RegisterForm extends StatefulWidget {
  bool _isPasswordHidden = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              validator: (value) {
                // TODO
              },
              controller: widget._emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                labelText: 'Email',
                hintText: 'example@gmail.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              validator: (value){
                // TODO
              },
              controller: widget._passwordController,
              obscureText: widget._isPasswordHidden,
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
                      widget._isPasswordHidden = !widget._isPasswordHidden;
                    });
                  },
                  icon: Icon(widget._isPasswordHidden
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                if(!_formKey.currentState!.validate()) return;

                AuthController().createUser(widget._emailController.text, widget._passwordController.text);

                // Remove Every Screen and Leave Only the New One
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.home, ModalRoute.withName('/'));
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
