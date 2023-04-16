import 'package:flutter/material.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/controllers/register_controller.dart';
import 'package:itflowapp/main.dart';
import 'package:file_picker/file_picker.dart';

class EnterpriseForm extends StatefulWidget {
  final RegisterFormController _controller;

  EnterpriseForm({Key? key, required RegisterFormController controller})
      : _controller = controller,
        super(key: key);

  @override
  State<EnterpriseForm> createState() => _EnterpriseFormState();
}

class _EnterpriseFormState extends State<EnterpriseForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget._controller.logoSnapshot ?? const Text("No file chosen."),
              OutlinedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    withData: true,
                    allowedExtensions: ['jpg', 'png', 'jpeg', 'gif'],
                  );
                  if (result != null) {
                    setState(() {
                      widget._controller.logoFile = result.files.single;
                    });
                  }
                },
                child: const Text("Upload your logo"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: widget._controller.addressValidator,
            controller: widget._controller.addressController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.location_city),
              labelText: "Address",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: widget._controller.siteUrlValidator,
            controller: widget._controller.siteUrlController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.insert_link),
              labelText: "Site URL",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: widget._controller.eDescriptionValidator,
            controller: widget._controller.eDescriptionController,
            minLines: 3,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16.0),
              labelText: "Description",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
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
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                widget._controller.submit().then((isAllGood) {
                  if (isAllGood) {
                    // Remove Every Screen and Leave Only the New One
                    Navigator.pushNamedAndRemoveUntil(
                      context, Routes.home, ModalRoute.withName('/'));
                  } else {
                    setState((){});
                  }
              });
              },
              child: const Text('Submit'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: (widget._controller.errorMessage == null)
                  ? Container()
                  : Text(
                widget._controller.errorMessage!,
                style: const TextStyle(color: AppColors.red),
              ),
            ),
          ),
        ],
      )
    );
  }
}