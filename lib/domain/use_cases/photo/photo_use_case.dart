import 'package:image_picker/image_picker.dart';
import 'package:navigation_dashboard/domain/models/photo/repository/photo_repository.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/photo/photo_db.dart';

class PhotoUseCase {
  final PhotoRepository _photoRepository;
  PhotoUseCase(this._photoRepository);

  Future<String> uploadPhoto(CollectionStorage collectionStorage, String id, XFile? photo) => _photoRepository.uploadPhoto(collectionStorage, id, photo);
  Future<String> downloadURL(String photoPath) => _photoRepository.downloadURL(photoPath);
  Future deletePhoto(String photoPath) => _photoRepository.deletePhoto(photoPath);
}