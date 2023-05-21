import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/domain/use_cases/photo/photo_use_case.dart';
import 'package:navigation_dashboard/domain/use_cases/product/product_use_case.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/photo/photo_db.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/product/product_db.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';

final productProvider = StateNotifierProvider.autoDispose((ref,) {
    ref.keepAlive();
    return ProductNotifier();
  });

final productDetailsProvider = StateProvider.autoDispose<Product?>((ref) => null);

final productsFutureProvider = FutureProvider.autoDispose<List<Product>>((ref) async{
      return await ProductUseCase(ProductFirestore()).getAllProducts();
},);

final productStreamProvider = StreamProvider.autoDispose.family<Product?, String>((ref, idProduct) async*{
      await for( final product in ProductUseCase(ProductFirestore()).getProduct(idProduct)){
        yield product;
      }
},);

class ProductNotifier extends StateNotifier <Product?>{

  final ProductUseCase _productService = ProductUseCase(ProductFirestore());
  final PhotoUseCase _storageService = PhotoUseCase(PhotoStorage());
  List <ProductSize> sizes =[];

  ProductNotifier():super(null);

  int formatterSizes(List <Map<String, TextEditingController>> controllerSizes){
    int validateStateProduct = 0;
    sizes.clear();
    for (int i = 0; i < controllerSizes.length ;i++) {
      TextEditingController size = controllerSizes[i]['size']!;
      TextEditingController amount = controllerSizes[i]['amount']!;
      validateStateProduct += int.parse(amount.text);
      sizes.add(ProductSize(
        size: size.text.toUpperCase(), 
        amount: int.parse(amount.text), 
        state: int.parse(amount.text) > 0 ? Strings.productAvailable : Strings.productNotAvailable, 
        quantityUpdateDate: Formatter.dateFormat()
      ));
    }
    return validateStateProduct;
  }


  Future <bool> addProduct(XFile? photo, List <Map<String, TextEditingController>> controllerSizes, Product product) async {
    bool validate = false;
    product.pinta = product.pinta.length == 1 ? 'P0${product.pinta}': 'P${product.pinta}';
    product.id = product.reference + product.pinta;

    //FORMATTER sizes AND ADD STATE PRODUCT VALIDATE
    product.state = formatterSizes(controllerSizes) > 0 ? Strings.productAvailable : Strings.productNotAvailable;
    //FORMATTER Site
    product.site = product.site.replaceAll('${Strings.siteProduct} ', '');

    if(photo != null && product.id != null){
      //ADD PHOTO
      String photoPath  = await _storageService.uploadPhoto(CollectionStorage.products, product.id! , photo );
      String photoURL = await _storageService.downloadURL(photoPath);
      product.photoPath = photoPath;
      product.photoURL = photoURL;
      //ADD PRODUCT
      await _productService.addProduct(product).whenComplete(() => validate = true).onError((error, stackTrace) => validate = false);
      if(validate){
        //ADD PRODUCT SIZES
        await _productService.addSizesOfProduct(product.id!, sizes).whenComplete(() => validate = true).onError((error, stackTrace) => validate = false);
      }
    }
    return validate;
  }
  
  Future <bool> updateProduct(XFile? photo, List <Map<String, TextEditingController>> controllerSizes, Product product) async {
    bool validate = true;
    
    if(photo != null){
      //UPDATE PHOTO
      await _storageService.deletePhoto(product.photoPath);
      String photoPath  = await _storageService.uploadPhoto(CollectionStorage.products, product.id! , photo );
      String photoURL = await _storageService.downloadURL(photoPath);
      product.photoPath = photoPath;
      product.photoURL = photoURL;
    }
    //Add ID PRODUCT
    product.id = product.reference + product.pinta;
    //FORMATTER sizes AND ADD STATE PRODUCT VALIDATE
    product.state = formatterSizes(controllerSizes) > 0 ? Strings.productAvailable : Strings.productNotAvailable;
    //FORMATTER Site
    product.site = product.site.replaceAll('${Strings.siteProduct} ', '');
    //UPDATE PRODUCT
    await _productService.updateProduct(product).whenComplete(() => validate = true).onError((error, stackTrace) => validate = false);
    //UPDATE PRODUCT SIZES
    if(validate){
      await _productService.updateSizesOfProduct(product.id!, sizes).whenComplete(() => validate = true).onError((error, stackTrace) => validate = false);
    }

    return validate;
  }

  Future <bool> deleteProduct(Product product) async{
    bool validate= false;
    product.id = product.reference + product.pinta;
    await _productService.deleteProduct(product.id!).whenComplete(() => validate= true).onError((error, stackTrace) => validate=false);
    if(validate){
      await _storageService.deletePhoto(product.photoPath).whenComplete(() => validate= true).onError((error, stackTrace) => validate=false);
    }
    return validate;
  }

}