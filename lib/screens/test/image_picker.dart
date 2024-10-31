import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'custom_camera_widget.dart'; // Import the custom camera widget

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image; // Variable to store the selected image

  void _openCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomCameraWidget(onImageCaptured: (XFile image) {
          setState(() {
            _image = File(image.path); // Store the captured image
          });
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _openCamera, // Open the custom camera on tap
              child: CircleAvatar(
                radius: 60, // Radius of the circular image
                backgroundImage: _image != null ? FileImage(_image!) : null, // Display the image if selected
                child: _image == null
                    ? const Icon(Icons.camera_alt, size: 60) // Icon when no image is selected
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tap to capture an image',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
