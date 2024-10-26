import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native_features_and_storage/viewutils/widgets_extensions.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onChooseImage});

  final Function(File file) onChooseImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? imageFile;

  void takePictute({required bool viaCamera}) async {
    final imagePicker = ImagePicker();
    XFile? pickedImage;
    if (viaCamera) {
      pickedImage = await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    } else {
      pickedImage = await imagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    }
    if (pickedImage == null) {
      return;
    }
    setState(() {
      imageFile = File(pickedImage!.path);
      widget.onChooseImage(imageFile!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.purple)),
      //  height: 250,
      width: double.infinity,
      alignment: imageFile == null ? Alignment.center : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageFile != null)
            SizedBox(
              height: 250,
              child: Image.file(
                imageFile!,
                fit: BoxFit.fitHeight,
                // width: double.infinity,
                // height: double.infinity,
              ),
            ).spaceTo(bottom: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  takePictute(viaCamera: false);
                },
                child: const Icon(Icons.photo_size_select_actual_outlined),
              ),
              GestureDetector(
                  onTap: () {
                    takePictute(viaCamera: true);
                  },
                  child: const Icon(Icons.camera)),
            ],
          ),
        ],
      ).paddingSymmetric(vertical: 8),
    );
  }
}
