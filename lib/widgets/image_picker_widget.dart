import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:g_solution/widgets/ink_well_widget.dart';

class ImagePickerWidget extends StatefulWidget {
  final ValueChanged<File?> onImagePicked; // Callback to handle picked image

  const ImagePickerWidget({Key? key, required this.onImagePicked}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image;

  void _pickImage({ImageSource source = ImageSource.gallery}) async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      widget.onImagePicked(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     IconButton(
    //       onPressed: () => _pickImage(source: ImageSource.gallery),
    //       icon: Icon(Icons.photo_library),
    //     ),
    //   ],
    // );
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: InkWellWidget(
        buttonName: "Select Image",
        buttonColor: Colors.white,
        fontSize: 20,
        onPress: (){
          _pickImage(source: ImageSource.gallery);
        },
      ),

    );
  }
}
