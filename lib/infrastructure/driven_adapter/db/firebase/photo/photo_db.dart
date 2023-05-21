import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation_dashboard/domain/models/photo/repository/photo_repository.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/photo/error/photo_db_error.dart';
import 'package:uuid/uuid.dart';
import '../../../../helpers/collections.dart';

enum CollectionStorage {
  products,
  users,
}

class PhotoStorage extends PhotoRepository{

  final FirebaseStorage _storage = FirebaseStorage.instance;
  
  @override
  Future<String> uploadPhoto(CollectionStorage collectionStorage, String id, XFile? photo) async{

    String photoId = const Uuid().v4();
    String collection = (collectionStorage == CollectionStorage.products) ? Collections.products : Collections.users;
    String storagePath = '$collection/$id/$photoId.jpg';
    log(photo.toString());
    try{
      final ref = _storage.ref().child(storagePath);
      final data = await photo?.readAsBytes();
      await ref.putData(data!).whenComplete(() { log('UploadTask: complete');});
      return storagePath;
    }catch (e){
      log(e.toString());
      throw UploadPhotoDbError();
    }
  }

  @override
  Future<String> downloadURL(String photoPath) async{
    try{
      final Reference storageReference = _storage.ref().child(photoPath);
      String photoURL = await storageReference.getDownloadURL();
      return photoURL;
    }catch (e){
      log(e.toString());
      throw DownloadURLPhotoDbError();
    }

  }

  @override
  Future deletePhoto(String photoPath) async{
    try{
      final Reference storageReference = _storage.ref().child(photoPath);
      return await storageReference.delete();
    }catch(e){
      log(e.toString());
      throw DeletePhotoPhotoDbError();
    }
  }

}