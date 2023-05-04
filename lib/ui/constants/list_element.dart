import 'package:flutter/material.dart';
import 'package:navigation_dashboard/infrastructure/helpers/fields.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_dashboard/ui/constants/roles.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_design/tokens/colors.dart';

class ProductSites {
  final String id;
  final String name;
  const ProductSites(this.id, this.name,);
}
    
class ListElement{

  //Select states 
  static const List<String> productState = [Strings.productAvailable, Strings.productNotAvailable, Strings.productReservation];
  static const List<String> userState= [Strings.userActive, Strings.userInactive, Strings.userPending];
  static const List<String> orderState = [Strings.orderPending, Strings.orderPaid, Strings.orderDispatched, Strings.orderCancel, Strings.orderComplete];
  // Elements Type
  static const List<ProductSites> productSite = [ 
    ProductSites('01', '${Strings.siteProduct} 1'), 
    ProductSites('02', '${Strings.siteProduct} 2'),
    ProductSites('03', '${Strings.siteProduct} 3'),
    ProductSites('04', '${Strings.siteProduct} 4'),
    ProductSites('05', '${Strings.siteProduct} 5'),
    ProductSites('06', '${Strings.siteProduct} 6'),
    ProductSites('07', '${Strings.siteProduct} 7'),
    ProductSites('08', '${Strings.siteProduct} 8'),
    ProductSites('09', '${Strings.siteProduct} 9'),
    ProductSites('10', '${Strings.siteProduct} 10'),
    ProductSites('11', '${Strings.siteProduct} 11'),
    ProductSites('12', '${Strings.siteProduct} 12'),
    ProductSites('13', '${Strings.siteProduct} 13'),
    ProductSites('14', '${Strings.siteProduct} 14'),
    ProductSites('15', '${Strings.siteProduct} 15'),
    ProductSites('16', '${Strings.siteProduct} 16'),
    ProductSites('17', '${Strings.siteProduct} 17'),
    ProductSites('18', '${Strings.siteProduct} 18'),
    ];
  static const List<String> rol = [Roles.admin, Roles.seller, Roles.warehouseAssistant, Roles.commercial];
  //Categories Images Card
  static const List<String> userCategoryImage= [Images.userActivate, Images.userInactivate, Images.userPending];
  static const List<String> orderCategoryImage = [Images.orderPending, Images.orderPaid, Images.orderDispatched, Images.orderCancel, Images.orderComplete];
  //Categories titles
  static const List<String> dashboardCategoryTitle= [Strings.allUsers, Strings.allProducts, Strings.allOrders];
  static const List<String> productCategoryTitle = [Strings.allStates, Strings.productAvailable, Strings.productNotAvailable, Strings.productReservation];
  static const List<String> userCategoryTitle = [Strings.allStates, Strings.userActive, Strings.userInactive, Strings.userPending];
  static const List<String> orderCategoryTitle = [Strings.allStates, Strings.orderPending, Strings.orderPaid, Strings.orderDispatched, Strings.orderCancel, Strings.orderComplete];
  //Categories colors
  static const List<Color?> dashboardCategoryColor= [primaryLightColor, white, white];
  static const List<Color?> productCategoryColor = [primaryLightColor, successColor, grey, buttonC];
  static const List<Color?> userCategoryColor= [primaryLightColor, successColor, grey, buttonC];
  static const List<Color?> orderCategoryColor = [primaryLightColor, buttonC, buttonG, secondaryLightColor, grey, successColor];
  //Colombia
  static const List<DepartmentCityType> departmentMunicipal = DepartmentCityType.values;

}

enum CardColorUserState{
  userActivate(state: Strings.userActive, color: successColor, image:  Images.userActivate),
  userInactivate( state: Strings.userInactive, color: grey, image:  Images.userInactivate ),
  userPending( state: Strings.userPending, color: buttonC, image:  Images.userPending );

  final String state;
  final Color color;
  final String image;
  const CardColorUserState({required this.state, required this.color, required this.image});
}

enum DepartmentCityType{
  select(department: '', municipal: []),
  amazonas(department: 'Amazonas', municipal: [ 'Leticia', 'El Encanto', 'La Chorrera', 'La Pedrera', 'La Victoria', 'Puerto Arica', 'Puerto Nariño', 'Puerto Santander', 'Tarapacá', 'Puerto Alegría', 'Miriti Paraná',]),
  antioquia(department: 'Antioquia', municipal: ['Medellín','Abejorral','Abriaquí','Alejandría','Amagá','Amalfi','Andes','Angelópolis','Angostura','Anorí','Anza','Apartadó','Arboletes','Argelia','Armenia','Barbosa','Bello','Betania','Betulia','Ciudad Bolívar','Briceño','Buriticá','Cáceres','Caicedo','Caldas','Campamento','Cañasgordas','Caracolí','Caramanta','Carepa','Carolina','Caucasia','Chigorodó','Cisneros','Cocorná','Concepción','Concordia','Copacabana','Dabeiba','Don Matías','Ebéjico','El Bagre','Entrerrios','Envigado','Fredonia','Giraldo','Girardota','Gómez Plata','Guadalupe','Guarne','Guatapé','Heliconia','Hispania','Itagui','Ituango','Belmira','Jericó','La Ceja','La Estrella','La Pintada','La Unión','Liborina','Maceo','Marinilla','Montebello','Murindó','Mutatá','Nariño','Necoclí','Nechí','Olaya','Peñol','Peque','Pueblorrico','Puerto Berrío','Puerto Nare','Puerto Triunfo','Remedios','Retiro','Rionegro','Sabanalarga','Sabaneta','Salgar','San Francisco','San Jerónimo','San Luis','San Pedro','San Rafael','San Roque','San Vicente','Santa Bárbara','Santo Domingo','El Santuario','Segovia','Sopetrán','Támesis','Tarazá','Tarso','Titiribí','Toledo','Turbo','Uramita','Urrao','Valdivia','Valparaíso','Vegachí','Venecia','Yalí','Yarumal','Yolombó','Yondó','Zaragoza','San Pedro de Uraba','Santafé de Antioquia','Santa Rosa de Osos','San Andrés de Cuerquía','Vigía del Fuerte','San José de La Montaña','San Juan de Urabá','El Carmen de Viboral','San Carlos','Frontino','Granada','Jardín','Sonsón', ]),
  arauca(department: 'Arauca', municipal: ['Arauquita','Cravo Norte','Fortul','Puerto Rondón','Saravena','Tame','Arauca',]),
  atlantico(department: 'Atlántico', municipal: ['Barranquilla','Baranoa','Candelaria','Galapa','Luruaco','Malambo','Manatí','Piojó','Polonuevo','Sabanagrande','Sabanalarga','Santa Lucía','Santo Tomás','Soledad','Suan','Tubará','Usiacurí','Juan de Acosta','Palmar de Varela','Campo de La Cruz','Repelón','Puerto Colombia','Ponedera',]),
  bogota(department: 'Bogotá D.C.', municipal: ['Bogotá D.C.']),
  bolivar(department:'Bolívar'	, municipal: ['Achí','Arenal','Arjona','Arroyohondo','Calamar','Cantagallo','Cicuco','Córdoba','Clemencia','El Guamo','Magangué','Mahates','Margarita','Montecristo','Mompós','Morales','Norosí','Pinillos','Regidor','Río Viejo','San Estanislao','San Fernando','San Juan Nepomuceno','Santa Catalina','Santa Rosa','Simití','Soplaviento','Talaigua Nuevo','Tiquisio','Turbaco','Turbaná','Villanueva','Barranco de Loba','Santa Rosa del Sur','Hatillo de Loba','El Carmen de Bolívar','San Martín de Loba','Altos del Rosario','San Jacinto del Cauca','San Pablo de Borbur','San Jacinto','El Peñón','Cartagena','María la Baja','San Cristóbal','Zambrano',]),
  boyaca(department:'Boyacá'	, municipal: ['Tununguá','Motavita','Ciénega','Tunja','Almeida','Aquitania','Arcabuco','Berbeo','Betéitiva','Boavita','Boyacá','Briceño','Buena Vista','Busbanzá','Caldas','Campohermoso','Cerinza','Chinavita','Chiquinquirá','Chiscas','Chita','Chitaraque','Chivatá','Cómbita','Coper','Corrales','Covarachía','Cubará','Cucaita','Cuítiva','Chíquiza','Chivor','Duitama','El Cocuy','El Espino','Firavitoba','Floresta','Gachantivá','Gameza','Garagoa','Guacamayas','Guateque','Guayatá','Güicán','Iza','Jenesano','Jericó','Labranzagrande','La Capilla','La Victoria','Macanal','Maripí','Miraflores','Mongua','Monguí','Moniquirá','Muzo','Nobsa','Nuevo Colón','Oicatá','Otanche','Pachavita','Páez','Paipa','Pajarito','Panqueba','Pauna','Paya','Pesca','Pisba','Puerto Boyacá','Quípama','Ramiriquí','Ráquira','Rondón','Saboyá','Sáchica','Samacá','San Eduardo','San Mateo','Santana','Santa María','Santa Sofía','Sativanorte','Sativasur','Siachoque','Soatá','Socotá','Socha','Sogamoso','Somondoco','Sora','Sotaquirá','Soracá','Susacón','Sutamarchán','Sutatenza','Tasco','Tenza','Tibaná','Tinjacá','Tipacoque','Toca','Tópaga','Tota','Turmequé','Tutazá','Umbita','Ventaquemada','Viracachá','Zetaquira','Togüí','Villa de Leyva','Paz de Río','Santa Rosa de Viterbo','San Pablo de Borbur','San Luis de Gaceno','San José de Pare','San Miguel de Sema','Tuta','Tibasosa','La Uvita','Belén',]),
  caldas(department:'Caldas'	, municipal: ['Manizales','Aguadas','Anserma','Aranzazu','Belalcázar','Chinchiná','Filadelfia','La Dorada','La Merced','Manzanares','Marmato','Marulanda','Neira','Norcasia','Pácora','Palestina','Pensilvania','Riosucio','Risaralda','Salamina','Samaná','San José','Supía','Victoria','Villamaría','Viterbo','Marquetalia',]),
  caqueta(department:'Caquetá'	, municipal: ['Florencia','Albania','Curillo','El Doncello','El Paujil','Morelia','Puerto Rico','Solano','Solita','Valparaíso','San José del Fragua','Belén de Los Andaquies','Cartagena del Chairá','Milán','La Montañita','San Vicente del Caguán']),
  casanare(department:'Casanare'	, municipal: ['Yopal','Aguazul','Chámeza','Hato Corozal','La Salina','Monterrey','Pore','Recetor','Sabanalarga','Sácama','Tauramena','Trinidad','Villanueva','San Luis de Gaceno','Paz de Ariporo','Nunchía','Maní','Támara','Orocué',]),
  cauca(department: 	'Cauca'	, municipal: ['Popayán','Almaguer','Argelia','Balboa','Bolívar','Buenos Aires','Cajibío','Caldono','Caloto','Corinto','El Tambo','Florencia','Guachené','Guapi','Inzá','Jambaló','La Sierra','La Vega','López','Mercaderes','Miranda','Morales','Padilla','Patía','Piamonte','Piendamó','Puerto Tejada','Puracé','Rosas','Santa Rosa','Silvia','Sotara','Suárez','Sucre','Timbío','Timbiquí','Toribio','Totoró','Villa Rica','Santander de Quilichao','San Sebastián','Páez',]),
  cesar(department: 	'Cesar'	, municipal: ['Valledupar','Aguachica','Agustín Codazzi','Astrea','Becerril','Bosconia','Chimichagua','Chiriguaná','Curumaní','El Copey','El Paso','Gamarra','González','La Gloria','Manaure','Pailitas','Pelaya','Pueblo Bello','La Paz','San Alberto','San Diego','San Martín','Tamalameque','Río de Oro','La Jagua de Ibirico',]),
  choco(department: 	'Chocó'	, municipal: ['Istmina','Quibdó','Acandí','Alto Baudo','Atrato','Bagadó','Bahía Solano','Bajo Baudó','Bojaya','Cértegui','Condoto','Juradó','Lloró','Medio Atrato','Medio Baudó','Medio San Juan','Nóvita','Nuquí','Río Iro','Río Quito','Riosucio','Sipí','Unguía','El Litoral del San Juan','El Cantón del San Pablo','El Carmen de Atrato','San José del Palmar','Belén de Bajira','Carmen del Darien','Tadó','Unión Panamericana',]),
  cordoba(department: 	'Córdoba'	, municipal: ['San Bernardo del Viento','Montería','Ayapel','Buenavista','Canalete','Cereté','Chimá','Chinú','Cotorra','Lorica','Los Córdobas','Momil','Moñitos','Planeta Rica','Pueblo Nuevo','Puerto Escondido','Purísima','Sahagún','San Andrés Sotavento','San Antero','San Pelayo','Tierralta','Tuchín','Valencia','San José de Uré','Ciénaga de Oro','San Carlos','Montelíbano','La Apartada','Puerto Libertador',]),
  cundinamarca(department: 	'Cundinamarca'	, municipal: ['Anapoima','Arbeláez','Beltrán','Bituima','Bojacá','Cabrera','Cachipay','Cajicá','Caparrapí','Caqueza','Chaguaní','Chipaque','Choachí','Chocontá','Cogua','Cota','Cucunubá','El Colegio','El Rosal','Fomeque','Fosca','Funza','Fúquene','Gachala','Gachancipá','Gachetá','Girardot','Granada','Guachetá','Guaduas','Guasca','Guataquí','Guatavita','Guayabetal','Gutiérrez','Jerusalén','Junín','La Calera','La Mesa','La Palma','La Peña','La Vega','Lenguazaque','Macheta','Madrid','Manta','Medina','Mosquera','Nariño','Nemocón','Nilo','Nimaima','Nocaima','Venecia','Pacho','Paime','Pandi','Paratebueno','Pasca','Puerto Salgar','Pulí','Quebradanegra','Quetame','Quipile','Apulo','Ricaurte','San Bernardo','San Cayetano','San Francisco','Sesquilé','Sibaté','Silvania','Simijaca','Soacha','Subachoque','Suesca','Supatá','Susa','Sutatausa','Tabio','Tausa','Tena','Tenjo','Tibacuy','Tibirita','Tocaima','Tocancipá','Topaipí','Ubalá','Ubaque','Une','Útica','Vianí','Villagómez','Villapinzón','Villeta','Viotá','Zipacón','San Juan de Río Seco','Villa de San Diego de Ubate','Guayabal de Siquima','San Antonio del Tequendama','Agua de Dios','Carmen de Carupa','Vergara','Albán','Anolaima','Chía','El Peñón','Sopó','Gama','Sasaima','Yacopí','Fusagasugá','Zipaquirá','Facatativá',]),
  guainia(department: 	'Guainía'	, municipal: ['Inírida','Barranco Minas','Mapiripana','San Felipe','Puerto Colombia','La Guadalupe','Cacahual','Pana Pana','Morichal',]),
  guaviare(department: 	'Guaviare'	, municipal: ['Calamar','San José del Guaviare','Miraflores','El Retorno',]),
  huila(department: 	'Huila'	, municipal: ['Neiva','Acevedo','Agrado','Aipe','Algeciras','Altamira','Baraya','Campoalegre','Colombia','Elías','Garzón','Gigante','Guadalupe','Hobo','Iquira','Isnos','La Argentina','La Plata','Nátaga','Oporapa','Paicol','Palermo','Palestina','Pital','Pitalito','Rivera','Saladoblanco','Santa María','Suaza','Tarqui','Tesalia','Tello','Teruel','Timaná','Villavieja','Yaguará','San Agustín',]),
  guajira(department: 	'La Guajira'	, municipal: ['Riohacha','Albania','Barrancas','Dibula','Distracción','El Molino','Fonseca','Hatonuevo','Maicao','Manaure','Uribia','Urumita','Villanueva','La Jagua del Pilar','San Juan del Cesar',]),
  magdalena(department: 	'Magdalena'	, municipal: ['Santa Marta','Algarrobo','Aracataca','Ariguaní','Cerro San Antonio','Chivolo','Concordia','El Banco','El Piñon','El Retén','Fundación','Guamal','Nueva Granada','Pedraza','Pivijay','Plato','Remolino','Salamina','San Zenón','Santa Ana','Sitionuevo','Tenerife','Zapayán','Zona Bananera','San Sebastián de Buenavista','Sabanas de San Angel','Pijiño del Carmen','Santa Bárbara de Pinto','Pueblo Viejo','Ciénaga',]),
  meta(department: 	'Meta'	, municipal: ['Uribe','Villavicencio','Acacias','Cabuyaro','Cubarral','Cumaral','El Calvario','El Castillo','El Dorado','Granada','Guamal','Mapiripán','Mesetas','La Macarena','Lejanías','Puerto Concordia','Puerto Gaitán','Puerto López','Puerto Lleras','Puerto Rico','Restrepo','San Juanito','San Martín','Vista Hermosa','Barranca de Upía','Fuente de Oro','San Carlos de Guaroa','San Juan de Arama','Castilla la Nueva',]),
  narino(department: 	'Nariño'	, municipal: ['Santacruz','Pasto','Albán','Aldana','Ancuyá','Barbacoas','Colón','Consaca','Contadero','Córdoba','Cuaspud','Cumbal','Cumbitara','El Charco','El Peñol','El Rosario','El Tambo','Funes','Guachucal','Guaitarilla','Gualmatán','Iles','Imués','Ipiales','La Cruz','La Florida','La Llanada','La Tola','La Unión','Leiva','Linares','Los Andes','Magüí','Mallama','Mosquera','Nariño','Olaya Herrera','Ospina','Francisco Pizarro','Policarpa','Potosí','Providencia','Puerres','Pupiales','Ricaurte','Roberto Payán','Samaniego','Sandoná','San Bernardo','San Lorenzo','San Pablo','Santa Bárbara','Sapuyes','Taminango','Tangua','Túquerres','Yacuanquer','San Pedro de Cartago','El Tablón de Gómez','Buesaco','San Andrés de Tumaco','Belén','Chachagüí','Arboleda',]),
  norteSantander(department: 	'Norte de Santander'	, municipal: ['Silos','Cácota','Toledo','Mutiscua','El Zulia','Salazar','Cucutilla','Puerto Santander','Gramalote','El Tarra','Teorama','Arboledas','Lourdes','Bochalema','Convención','Hacarí','Herrán','Tibú','San Cayetano','San Calixto','La Playa','Chinácota','Ragonvalia','La Esperanza','Villa del Rosario','Chitagá','Sardinata','Abrego','Los Patios','Ocaña','Bucarasica','Santiago','Labateca','Cachirá','Villa Caro','Durania','Pamplona','Pamplonita','Cúcuta','El Carmen',]),
  putumayo(department: 	'Putumayo'	, municipal: ['Mocoa','Colón','Orito','Puerto Caicedo','Puerto Guzmán','Leguízamo','Sibundoy','San Francisco','San Miguel','Santiago','Valle de Guamez','Puerto Asís','Villagarzón',]),
  quindio(department: 	'Quindío'	, municipal: ['Armenia','Buenavista','Circasia','Córdoba','Filandia','La Tebaida','Montenegro','Pijao','Quimbaya','Salento','Calarcá','Génova',]),
  risaralda(department: 	'Risaralda'	, municipal: ['Pereira','Apía','Balboa','Dosquebradas','Guática','La Celia','La Virginia','Marsella','Mistrató','Pueblo Rico','Quinchía','Santuario','Santa Rosa de Cabal','Belén de Umbría',]),
  santander(department: 	'Santander'	, municipal: ['Puerto Wilches','Puerto Parra','Bucaramanga','Aguada','Albania','Aratoca','Barbosa','Barichara','Barrancabermeja','Betulia','Bolívar','Cabrera','California','Carcasí','Cepitá','Cerrito','Charalá','Charta','Chipatá','Cimitarra','Concepción','Confines','Contratación','Coromoro','Curití','El Guacamayo','El Playón','Encino','Enciso','Florián','Floridablanca','Galán','Gambita','Girón','Guaca','Guadalupe','Guapotá','Guavatá','Güepsa','Jesús María','Jordán','La Belleza','Landázuri','La Paz','Lebríja','Los Santos','Macaravita','Málaga','Matanza','Mogotes','Molagavita','Ocamonte','Oiba','Onzaga','Palmar','Páramo','Piedecuesta','Pinchote','Puente Nacional','Rionegro','San Andrés','San Gil','San Joaquín','San Miguel','Santa Bárbara','Simacota','Socorro','Suaita','Sucre','Suratá','Tona','Vélez','Vetas','Villanueva','Zapatoca','Palmas del Socorro','San Vicente de Chucurí','San José de Miranda','Santa Helena del Opón','Sabana de Torres','El Carmen de Chucurí','Valle de San José','San Benito','Hato','Chimá','Capitanejo','El Peñón',]),
  sucre(department: 	'Sucre'	, municipal: ['Sincelejo','Buenavista','Caimito','Coloso','Coveñas','Chalán','El Roble','Galeras','Guaranda','La Unión','Los Palmitos','Majagual','Morroa','Ovejas','Palmito','San Benito Abad','San Marcos','San Onofre','San Pedro','Sucre','Tolú Viejo','San Luis de Sincé','San Juan de Betulia','Santiago de Tolú','Sampués','Corozal',]),
  tolima(department: 	'Tolima'	, municipal: ['Alpujarra','Alvarado','Ambalema','Armero','Ataco','Cajamarca','Chaparral','Coello','Coyaima','Cunday','Dolores','Espinal','Falan','Flandes','Fresno','Guamo','Herveo','Honda','Icononzo','Mariquita','Melgar','Murillo','Natagaima','Ortega','Palocabildo','Piedras','Planadas','Prado','Purificación','Rio Blanco','Roncesvalles','Rovira','Saldaña','Santa Isabel','Venadillo','Villahermosa','Villarrica','Valle de San Juan','Carmen de Apicala','San Luis','San Antonio','Casabianca','Anzoátegui','Ibagué','Líbano','Lérida','Suárez',]),
  valleCauca(department: 	'Valle del Cauca'	, municipal: ['El Dovio','Roldanillo','Argelia','Sevilla','Zarzal','El Cerrito','Cartago','Caicedonia','El Cairo','La Unión','Restrepo','Dagua','Guacarí','Ansermanuevo','Bugalagrande','La Victoria','Ginebra','Yumbo','Obando','Bolívar','Cali','San Pedro','Guadalajara de Buga','Calima','Andalucía','Pradera','Yotoco','Palmira','Riofrío','Alcalá','Versalles','El Águila','Toro','Candelaria','La Cumbre','Ulloa','Trujillo','Vijes','Tuluá','Florida','Jamundí','Buenaventura',]),
  vaupes(department: 	'Vaupés'	, municipal: ['Mitú','Carurú','Taraira','Papunahua','Yavaraté','Pacoa',]),
  vichada(department: 	'Vichada'	, municipal: ['Puerto Carreño','La Primavera','Santa Rosalía','Cumaribo',]);
  final String department;
  final List<String> municipal;
  const DepartmentCityType({required this.department, required this.municipal,});
}