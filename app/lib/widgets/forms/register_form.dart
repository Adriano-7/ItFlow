import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:itflowapp/main.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/widgets/double_button.dart';
import '../../controllers/register_controller.dart';

class RegisterForm extends StatefulWidget {
  String userType = "Standard";
  bool _isPasswordHidden = true;
  bool _isRepeatPasswordHidden = true;
  final _controller = RegisterFormController();
  RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();

  void changeUser(){
    if(userType=="Standard"){
       userType = "Enterprise";
    }
    else if(userType=="Enterprise"){
      userType = "Standard";
    }
      
  }
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
          DoubleButton(
            onPressedFirst: widget.changeUser, 
            onPressedSecond: widget.changeUser, 
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
              prefixIcon: Icon(Icons.person_outline),
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
              prefixIcon: Icon(Icons.email_outlined),
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
              prefixIcon: Icon(Icons.phone),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextFormField(
              validator: widget._controller.repeatPasswordValidator,
              controller: widget._controller.repeatPasswordController,
              obscureText: widget._isRepeatPasswordHidden,
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
                      widget._isRepeatPasswordHidden =
                          !widget._isRepeatPasswordHidden;
                    });
                  },
                  icon: Icon(widget._isRepeatPasswordHidden
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
              onPressed: () => widget._controller.submit(_formKey, context).then((value) {
                if (value) {
                  if(widget.userType=="Standard"){
                     // Remove Every Screen and Leave Only the New One
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.standardRegister, ModalRoute.withName('/'));
                  }
                  else{
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.enterpriseRegister, ModalRoute.withName('/'));
                  }
                   
                } else {
                  setState(() {});
                }
              }),
              child: const Text('Submit'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: (widget._controller.getErrorMessage == null)
                  ? Container()
                  : Text(
                      widget._controller.getErrorMessage!,
                      style: const TextStyle(color: AppColors.red),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
