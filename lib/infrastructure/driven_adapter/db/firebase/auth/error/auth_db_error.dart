class SignOutDbError implements Exception{

  @override
  String toString(){
    return 'Error al cerrar la sesión.';
  }
}

class SignInDbError implements Exception{

  @override
  String toString(){
    return 'Error al iniciar sesión.';
  }
}

class RestorePasswordDbError implements Exception{

  @override
  String toString(){
    return 'Error al restablecer la contraseña.';
  }
}

class AuthStateChangesDbError implements Exception{

  @override
  String toString(){
    return 'Error al encontrar los cambios de sesión.';
  }
}