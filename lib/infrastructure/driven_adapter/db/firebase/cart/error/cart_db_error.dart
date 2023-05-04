class AddCartItemDbError implements Exception{
  @override
  String toString() {
    return 'Error al agregar un producto al carrito de compras.';
  }
}

class GetCartItemDbError implements Exception{
  @override
  String toString() {
    return 'Error al obtener los productos del carrito de compras.';
  }
}

class UpdateCartItemDbError implements Exception{
  @override
  String toString() {
    return 'Error al actualizar el producto en el carrito de compras.';
  }
}

class DeleteCartItemDbError implements Exception{
  @override
  String toString() {
    return 'Error al eliminar el producto del carrito de compras.';
  }
}