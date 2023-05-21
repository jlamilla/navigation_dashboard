
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final photoProvider = StateNotifierProvider.autoDispose<PhotoNotifier,XFile?>((ref) => PhotoNotifier());
final photoURLProvider = StateProvider.autoDispose<String>((ref) => '');

class PhotoNotifier extends StateNotifier<XFile?> {

  PhotoNotifier():super(null);

  Future pickImage() async {
    try {
      //pick image
      state =  await ImagePicker().pickImage(source: ImageSource.gallery);
    
        //img = await _cropImage(imageFile: img);
    
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }
/*
  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.relativePath!);
    return croppedImage != null ? File(croppedImage.) : null;
  }*/

}