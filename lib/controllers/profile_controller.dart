import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfleController extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();

  File? _image;

  File? get image => _image;

//  from the gallery
  Future<void> pickImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('Image picked successfully');
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    notifyListeners();
  }

  // form the camare
  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('Image picked successfully');
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    notifyListeners();
  }
}
