import 'dart:io';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerService {
  Future<File?> pickImage({bool camera = false});
}

class ImagePickerServiceImpl implements ImagePickerService {
  late ImagePicker imagePicker;

  ImagePickerServiceImpl({ImagePicker? imagePicker}) {
    this.imagePicker = imagePicker ?? ImagePicker();
  }

  @override
  Future<File?> pickImage({bool camera = false}) async {
    var pickedImage = await imagePicker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedImage != null) return File(pickedImage.path);
  }
}