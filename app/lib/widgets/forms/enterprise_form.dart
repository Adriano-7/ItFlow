import 'package:flutter/material.dart';
import '../../controllers/register_controller.dart';
import 'package:itflowapp/main.dart';
class EnterpriseForm extends StatelessWidget {
  final _controller = RegisterFormController();
  final _formKey = GlobalKey<FormState>();
  EnterpriseForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding( //TODO upload logo 
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_pin),
                labelText: 'Upload your logo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding( //address
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField( 
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_city),
                labelText: "Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding( //site url
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField( 
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.insert_link),
                labelText: "Site URL",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding( //description
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField( 
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16.0),
                prefixIcon: const Icon(Icons.text_fields),
                labelText: "Brief Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
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