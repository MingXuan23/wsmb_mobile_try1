import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget buildBottomSheet(BuildContext context) {
  return Wrap(
    children: [
      ListTile(
        leading: Icon(Icons.camera_alt),
        title: Text('Camera'),
        onTap: () {
          // Handle camera option
          Navigator.pop(context, ImageSource.camera); // Close the bottom sheet
        },
      ),
      ListTile(
        leading: Icon(Icons.photo_library),
        title: Text(
          'Gallery',
        ),
        onTap: () {
          // Handle gallery option
          Navigator.pop(context, ImageSource.gallery); // Close the bottom sheet
        },
      ),
      ListTile(
        leading: Icon(Icons.cancel),
        title: Text('Cancel'),
        onTap: () {
          Navigator.pop(context); // Close the bottom sheet
        },
      ),
    ],
  );
}
