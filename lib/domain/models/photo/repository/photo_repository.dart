
import 'package:image_picker/image_picker.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/photo/photo_db.dart';

abstract class PhotoRepository{
  Future<String> uploadPhoto(CollectionStorage collectionStorage, String id, XFile? photo);
  Future<String> downloadURL(String photoPath);
  Future deletePhoto(String photoPath);
}