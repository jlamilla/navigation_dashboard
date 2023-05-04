class Strings {

  static const optionsMenu = 'Menú de opciones';
  static const select = 'Seleccionar';
  static const settings = 'Ajustes';
  static const dashboard = 'Panel principal';
  static const navigation = 'Navigation';
  static const tutorial = 'Tutoriales';
  static const buttonOk = 'Aceptar';
  static const buttonCancel = 'Cancelar';
  static const validateSelect = 'Debe seleccionar una opción del listado.';

  //Elements state

  static const allStates = 'Todos';

  // Start product state
  static const productAvailable = 'Disponible';
  static const productNotAvailable = 'Agotado';
  static const productReservation = 'Reserva';
  // End product state
  
  // Start user state
  static const userActive = 'Activo'; 
  static const userInactive = 'Inactivo';
  static const userPending = 'Pendiente';
  // End user state

  // Start order state
  static const orderPending = 'Pendiente';
  static const orderPaid = 'Pagado';
  static const orderDispatched = 'Despachado';
  static const orderCancel = 'Cancelado';
  static const orderComplete = 'Entregado';
  // End order state

  //WEB

  // Start dashboard analytic data
  static const allUsers = 'Total de usuarios';
  static const allProducts = 'Total de productos';
  static const allOrders = 'Total de pedidos';
  // End product state

  //Cards Buttons: Admin and Commercial
  static const buttonEdit = 'Modificar';
  static const buttonDelete = 'Eliminar';

  //----------------------
  //cartShopping
  static const cartShopping = 'Carrito de compras';
  static const cartNotItems = 'No hay prendas en el carrito';
  static const cartAdd = 'Añadir al carrito';
  static const cartAddAlert = 'Prenda agregada con éxito al carrito de compras';
  static const cartErrorAlert = 'Por favor seleccionar una talla y la cantidad que desea añadir al carrito.';

  //favoriteProducts
  static const favoriteProducts = 'Prendas favoritas';

  //Products
  static const products = 'Prendas';
  static const siteProduct = 'Estantería';
  static const searchProduct = 'Buscar prenda';
  static const searchMessageProduct = 'Filtrar por referencia, nombre o pinta';
  static const getProduct = 'Consultar prendas';
  static const addProduct = 'Crear prenda';
  static const addProductSize = 'Añadir talla';
  static const detailsProduct = 'Detalles de la prenda';
  static const delateProductSize = 'Eliminar talla';
  static const updateProduct = 'Actualizar prenda';
  static const updateProducts = 'Actualizar prendas';
  static const updateSizesProduct = 'Actualizar tallas';
  static const editSizesProduct = 'Modificar tallas';
  static const next = 'Continuar';
  static const notProducts = 'No hay prendas por mostrar';
  static const notProductsFavorite = 'No hay prendas añadidas a favoritos';

  //Users
  static const users = 'Usuarios';
  static const updateUser = 'Actualizar Usuario';
  static const createUser = 'Crear Usuario';
  static const getUsers = 'Consultar usuarios';
  static const loadingCreateUser = 'Creando el usuario';
  static const loadingCreateUserMessage = 'Crear usuario 0 de 1';
  static const searchUser = 'Buscar usuario';
  static const detailsUser = 'Perfil del usuario';
  static const searchMessageUser = 'Filtrar por identificación, nombre, correo o rol';
  static const updateProfile = 'Actualizar perfil';
  static const notUsers = 'No hay usuarios por mostrar';
  //Orders
  static const orders = 'Pedidos';
  static const updateOrder = 'Actualizar Pedido';
  static const ordersConsult = 'Consultar pedidos';
  static const orderCreate = 'Su pedido ha sido creado de forma exitosa';
  static const orderDetails = 'Detalles del pedido';
  static const addOrders = 'Crear pedido';
  static const searchOrder = 'Buscar pedido';
  static const searchMessageOrder = 'Filtrar por identificación, nombre, fecha, cantidad o precio';
  static const deleteOrder = '¿Está seguro que desea eliminar el pedido seleccionado?';
  static const cancelOrder = 'Cancelar el pedido';
  static const cancelAlertOrder = 'Pedido cancelado';
  static const notOrders = 'No hay ordenes por mostrar';

  //Aplication
  static const error = 'Algo está mal';
  static const loading = 'Cargando';

  //Auth - register
  static const auth = 'Ingresar';
  static const authTitle = 'Navigation';
  static const out = 'Cerrar sessión';
  static const authContent = 'Ingresar a tu cuenta';
  static const authSignIn = '¿ Ya tienes una cuenta ?';
  static const register = 'Vinculate a Navegation';
  static const authUserEmail = 'Correo electrónico';
  static const authUserPassword = 'Contraseña';
  static const userPasswordReset = 'Restablecer contraseña';
  static const userPasswordResetTitle = 'Restablecer';
  static const userPasswordResetContent = 'contraseña';
  static const emailSendResetPassword = 'Enviar correo';
  static const errorStateUser = 'El usuario se encuentra inactivo';
  static const errorUser = 'El usuario no se encuentra registrado con el correo electrónico suministrado.';
  static const bonding = 'Vinculate';
  static const bondingButton = 'Vincularme';
  static const bondingContext = 'Los datos personales aquí relacionados por usted serán utilizados para los fines de validar la información entregada, promover, proveer, facturar y distribuir los productos, garantizar el servicio postventa de la empresa, establecer un canal para la adecuada comunicación entre CONCEPTO BASICO DE MODA S.A.S. y sus clientes, proveedores, aliados comerciales, etc.; fidelizarlos, hacer investigaciones del cliente, sobre sus gustos, hábitos de consumo, análisis de características demográficas; mejora de la atención, innovar y perfeccionar los productos y servicios ofrecidos, al igual que dar a conocer noticias de interés y novedades; y en general mantener un adecuado conocimiento y comunicación del y con el cliente.';
  static const signOut = 'Cerrar sessión';
  static const errorRolUser = 'El usuario no cuenta con un rol asignado';
  static const signInValidate = 'Correo y/o contraseña incorrectos';
  static const validatePassword = 'La contraseña proporcionada es demasiado débil';
  static const validateEmail = 'La cuenta ya existe para ese correo electrónico, realiza el proceso de restablecer contraseña';
  static const sellerRegister = 'Ya casi terminas el proceso de vinculación \n uno de nuestros acesores se pondrá en contacto contigo, para continuar con el proceso.';

  //Register Screen

  static const dataProtection = 'Politica de protección de datos.';
  //Scan Barcode

  static const scanBarCodeAlert = 'La prenda escaneada no existe en el inventario, por favor verifique el código de barras e intente nuevamente.';
  static const scanBarCode = 'Escanear código de barras';
  static const scanBarCodeCancel = 'Lector de código de barras cancelado';
  //Alerts

  static const userAlertInactive = 'Usuario inactivo, comunicate con tu accesor';
  static const userAlertPending = 'Usuario en proceso de vinculación';
  static const userProfileAlert = 'Tu perfil ha sido actualizado';


  static const resetPasswordAlert = 'Contraseña restablecida, revisa tu correo.';
  static const resetPasswordAlertError = 'Correo no encontrado, por favor vinculate a Navigation.';

  static const successAlert = 'Felicidades';
  static const errorAlert = 'Error';
  static const warningAlert = '¡Importante!';
  static const helpAlert = 'Recuerda';
  static const deleteTitle = 'Eliminar';
  static const copyAlertContent = 'Información copiada en el portapapeles';
  static const deleteUserContent = '¿ Esta seguro que desea eliminar el usuario seleccionado?';
  static const deleteUserAlert = 'Se ha elimino el usuario exitosamente.';
  static const deleteProductAlert = 'Se ha elimino el producto exitosamente.';
  static const deleteOrderAlert = 'Se ha elimino la orden exitosamente.';
  static const warningProductSizeAlert = 'Necesita por lo menos agregar una talla para crear la prenda exitosamente.';
  static const errorCreateProductAlert = 'Algo ah salido mal vuelva a intentar crear la prenda.';
  static const deleteProductSizeContent = '¿ Seguro quiere eliminar la talla seleccionada?';
  static const successDeleteProductSizeAlert = 'Se ha eliminado con exito la talla';
  static const errorDeleteProductSizeAlert = 'Por favor seleccione por lo menos una talla para eliminar';
  static const helpProductSizeMaxContent = 'La cantidad maxima de tallas por prenda es de 9.';
  static const successProductContent = 'La prenda con ID';
  static const successUserContent = 'El usuario con C.C.';
  static const successCreateContent = 'se ha creado exitosamente';
  static const successUpdateContent = 'se ha actualizaco exitosamente';
  static const errorFormContent = 'Por favor ingresar todos los datos del formulario para continuar.';
  static const successUpdateProductSizeContent = 'Se han actualizado las tallas de forma exitosa.';
  static const errorUpdateProductSizeContent = 'Algo ah salido mal vuelva a intentar crear la prenda.';
  static const errorConsultProductSizesContent = 'Algo ah salido mal vuelva a intentar modificar las tallas de la prenda.';

  static const waitingEstateOrderAlert = 'Tu pedido actualmente se encuentra Pendiente a la espera de facturación.';
  static const invoicedEstateOrderAlert = 'Tu pedido actualmente se encuentra Facturado a la espera de ser despachado';
  static const dispatchedEstateOrderAlert = 'Tu pedido actualmente se encuentra Despachado en camino a tu dirección';
  static const cancelEstateOrderAlert = 'Tu pedido actualmente se encuentra Cancelado';



  static const dataTreatment = 'Autorizo a que mis datos personales sean incorporados en la base de datos de CONCEPTO BASICO DE MODA S.A.S y acepto que conozco la política de tratamiento de datos personales. De igual manera manifiesto, bajo la gravedad de juramento, que todos los datos aquí registrados son veraces, completos, exactos, reales y comprobables.';
  static const dataTreatmentUrl = 'https://www.catalogonavigation.com/_files/ugd/139f7e_deb31c32a5a74880b2cf71a3148b9157.pdf';



}
