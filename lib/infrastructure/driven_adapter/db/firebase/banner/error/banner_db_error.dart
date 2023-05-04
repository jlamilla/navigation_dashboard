class AddBannerDbError implements Exception {
  @override
  String toString() {
    return 'Error al añadir un banner';
  }
}

class GetBannerDbError implements Exception {
  @override
  String toString() {
    return 'Error al consultar el banner';
  }
}

class GetBannersDbError implements Exception {
  @override
  String toString() {
    return 'Error al consultar los banners';
  }
}

class UpdateBannerDbError implements Exception {
  @override
  String toString() {
    return 'Error al actualizar el banner';
  }
}

class DeleteBannerDbError implements Exception {
  @override
  String toString() {
    return 'Error al eliminar el banner';
  }
}