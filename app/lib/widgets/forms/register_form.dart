import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:itflowapp/controllers/auth.dart';
import 'package:itflowapp/main.dart';

class RegisterForm extends StatefulWidget {
  bool _isPasswordHidden = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatpasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  var firstPassword;
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
          const SizedBox(height: 16),
          Padding( //name entry
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              validator: (value) {
                if(value!.isEmpty){
                  return "Username can't be empty!";
                }
              },
              controller: widget._nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                labelText: 'Name',
                hintText: 'Faísca Raimundo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding( //email entry
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              validator: (value) {
                if(value!.isEmpty){
                  return "Email can't be empty!";
                }
              },
              controller: widget._emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
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
          Padding( //phone entry
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              validator: (value) {
                if(value!.isEmpty){
                  return "Phone number can't be empty!";
                }
              },
              controller: widget._phoneController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: 'Phone No.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(//password entry
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "password can't be empty!";
                }
              },
              onChanged:(value){
                widget.firstPassword=value;
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
          const SizedBox(height: 16),
          Padding(//repeat password entry
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "password can't be empty!";
                }
                if(value!=widget.firstPassword)
                  return "Passwords don't match!" ;

              },
              controller: widget._repeatpasswordController,
              obscureText: widget._isPasswordHidden,
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
            //full width button
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;

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
