import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomCameraWidget extends StatefulWidget {
  final Function(XFile) onImageCaptured;

  const CustomCameraWidget({required this.onImageCaptured, Key? key}) : super(key: key);

  @override
  _CustomCameraWidgetState createState() => _CustomCameraWidgetState();
}

class _CustomCameraWidgetState extends State<CustomCameraWidget> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // Get a list of available cameras
      final cameras = await availableCameras();
      // Select the first camera
      final camera = cameras.first;
      _controller = CameraController(camera, ResolutionPreset.medium);
      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture; // Ensure the camera is initialized
      setState(() {}); // Rebuild the widget after initialization
    } catch (e) {
      print("Error initializing camera: $e");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Camera Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      widget.onImageCaptured(pickedFile); // Return the picked image
      Navigator.pop(context); // Close the camera
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: CameraPreview(_controller!),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.camera),
                      onPressed: () async {
                        try {
                          final image = await _controller!.takePicture();
                          widget.onImageCaptured(image);
                          Navigator.pop(context); // Close the camera
                        } catch (e) {
                          print("Error capturing image: $e");
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.photo),
                      onPressed: _pickImageFromGallery, // Open gallery when pressed
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: Text('Error: ${snapshot.error}'), // Show error if occurs
          );
        }
      },
    );
  }
}
