class GetUserDbError implements Exception{

  @override
  String toString(){
    return 'Error al obtener la lista de usuarios.';
  }
}

class GetUserByIdDbError implements Exception{

  @override
  String toString(){
    return 'Error al obtener el usuario por medio del id.';
  }
}

class GetUserByEmailDbError implements Exception{

  @override
  String toString(){
    return 'Error al obtener el usuario por medio del correo.';
  }
}

class UpdateUserDbError implements Exception{

  @override
  String toString(){
    return 'Error al actualizar el usuario.';
  }
}

class DeleteUserByIdDbError implements Exception{

  @override
  String toString(){
    return 'Error al eliminar usuario.';
  }
}
