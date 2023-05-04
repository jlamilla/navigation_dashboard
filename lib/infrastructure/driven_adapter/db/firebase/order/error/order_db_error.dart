class AddOrderDbError implements Exception {
  @override
  String toString() {
    return 'Error al añadir una orden';
  }
}

class AddOrderDetailsDbError implements Exception {
  @override
  String toString() {
    return 'Error al añadir los detalles de la orden';
  }
}

class GetOrdersDbError implements Exception {
  @override
  String toString() {
    return 'Error al consultar las ordenes';
  }
}

class GetOrderDetailsDbError implements Exception {
  @override
  String toString() {
    return 'Error al consultar los dellates de la orden';
  }
}

class UpdateOrderDbError implements Exception {
  @override
  String toString() {
    return 'Error al actualizar la orden';
  }
}

class DeleteOrderDbError implements Exception {
  @override
  String toString() {
    return 'Error al eliminar la orden';
  }
}