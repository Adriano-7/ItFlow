import 'package:flutter/material.dart';
import '../../controllers/register_controller.dart';
import 'package:itflowapp/main.dart';
class StandardForm extends StatelessWidget {
  final _controller = RegisterFormController();
  final _formKey = GlobalKey<FormState>();
  StandardForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding( //location
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_pin),
                labelText: 'Location',
                hintText: 'Porto',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField( //TODO CV
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.file_copy_outlined),
                labelText: 'CV',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.zero,
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
              onPressed: () => _controller.submit(_formKey, context).then((value) {
                // Remove Every Screen and Leave Only the New One
                Navigator.pushNamedAndRemoveUntil(
                  context, Routes.home, ModalRoute.withName('/'));
                  
              }),
              child: const Text('Submit'),
            ),
          ),
        ],
      )
    );
  }
}