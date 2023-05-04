class UploadPhotoDbError implements Exception{
  @override
  String toString() {
    return 'Error al subir la imagen.';
  }
}

class DownloadURLPhotoDbError implements Exception{
  @override
  String toString() {
    return 'Error al descargar la url de la foto.';
  }
}

class DeletePhotoPhotoDbError implements Exception{
  @override
  String toString() {
    return 'Error al eliminar la foto.';
  }
}