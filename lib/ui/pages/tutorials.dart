import 'package:fluent_ui/fluent_ui.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';

class TutorialsPage extends StatelessWidget {
  
  const TutorialsPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expander(
          header: const Text('¿Comó creo una prenda?'),
          content: SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: const[
                  Text('Paso 1 : Debes dirijirte al menu izquierdo en la opción que dice prendas dar click'),
                  SizedBox(height: 20,),
                  FadeInImage(placeholder: AssetImage(Images.loading), image: AssetImage(Images.orderCancel), height: 200,),
                  SizedBox(height: 20,),
                  Text('Paso 2 : Se desplejara un listado de opciones, donde daras click en crear prenda.'),
                  SizedBox(height: 20,),
                  FadeInImage(placeholder: AssetImage(Images.loading), image: AssetImage(Images.orderCancel), height: 200,),
                  Text('Paso 3 : Llenar todos los datos de la prenda y dar click en continuar.'),
                  SizedBox(height: 20,),
                  FadeInImage(placeholder: AssetImage(Images.loading), image: AssetImage(Images.orderCancel), height: 200,),
                  SizedBox(height: 20,),
                  Text('Paso 4 : Luego debes llenar los datos de las tallas de la prenda y dar click en crear prenda.'),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}