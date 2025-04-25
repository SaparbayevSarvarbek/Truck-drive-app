import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCard extends StatefulWidget {
  const ImagePickerCard({super.key});

  @override
  State<ImagePickerCard> createState() => _ImagePickerCardState();
}

class _ImagePickerCardState extends State<ImagePickerCard> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  void _pickImage() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galereyadan tanlash'),
              onTap: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kameradan olish'),
              onTap: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: _image == null
          ? Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 30,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.teal
                    : Colors.blue,
              ),
              const SizedBox(height: 10),
              const Text("Расмни танланг"),
            ],
          ),
        ),
      )
          : Column(
        children: [
          Card(
            elevation: 5,
            child: Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(width: 1.5),
              ),
              child: Image.file(
                File(_image!.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Расм ўзгартириш учун ена бир марта босинг',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
