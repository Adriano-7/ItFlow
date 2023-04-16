import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/controllers/register_controller.dart';
import 'package:itflowapp/widgets/forms/enterprise_form.dart';
import 'package:itflowapp/widgets/forms/register_form.dart';
import 'package:itflowapp/widgets/forms/standard_form.dart';

class RegisterScreen extends StatefulWidget {
  final _controller = RegisterFormController();
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  void initState() {
    widget._controller.registerFormScreenController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget form;
    switch (widget._controller.screen) {
      case RegisterScreenType.main:
        form = RegisterForm(controller: widget._controller);
        break;
      case RegisterScreenType.standard:
        form = StandardForm(controller: widget._controller);
        break;
      case RegisterScreenType.enterprise:
        form = EnterpriseForm(controller: widget._controller);
    }

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(kAppName),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            child: form,
          ),
        ),
      ),
      onWillPop: () async {
        switch (widget._controller.screen) {
          case RegisterScreenType.main:
            return true;
          case RegisterScreenType.standard:
          case RegisterScreenType.enterprise:
            widget._controller.userType = UserType.standard;
            widget._controller.screen = RegisterScreenType.main;
        }
        return false;
      },
    );
  }
}
