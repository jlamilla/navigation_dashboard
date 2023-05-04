class GetFavoritesDbError implements Exception{

  @override
  String toString(){
    return 'Error al obtener los productos favoritos del usuario.';
  }
}

class GetFavoriteDbError implements Exception{

  @override
  String toString(){
    return 'Error al obtener el producto favorito del usuario.';
  }
}