import 'dart:developer';

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

final referenceProductProvider = StateProvider.autoDispose<String>((ref) => '');
final nameProductProvider = StateProvider.autoDispose<String>((ref) => '');
final descriptionProductProvider = StateProvider.autoDispose<String>((ref) => '');
final pintaProductProvider = StateProvider.autoDispose<String>((ref) => '');
final pintaDescriptionProductProvider = StateProvider.autoDispose<String>((ref) => '');
final priceProductProvider = StateProvider.autoDispose<String>((ref) => '');
final siteProductProvider = StateProvider.autoDispose<TextEditingController>((ref) =>TextEditingController());
final photoPathProductProvider = StateProvider.autoDispose<String>((ref) => '');
final photoURLProductProvider = StateProvider.autoDispose<String>((ref) => '');
final createDateProductProvider = StateProvider.autoDispose<String>((ref) => '');

final productProvider = StateNotifierProvider.autoDispose((ref) {
    return ProductNotifier(
      Product(
        photoPath: ref.watch(photoPathProductProvider),
        photoURL: ref.watch(photoURLProductProvider),
        reference: ref.watch(referenceProductProvider), 
        name: ref.watch(nameProductProvider), 
        description: ref.watch(descriptionProductProvider), 
        pinta: ref.watch(pintaProductProvider), 
        pintaDescription: ref.watch(pintaDescriptionProductProvider), 
        price: ref.watch(priceProductProvider), 
        site: ref.watch(siteProductProvider).text, 
        state: '',
        productCreateDate: ref.watch(createDateProductProvider).isEmpty ? Formatter.dateFormat() : ref.watch(createDateProductProvider), 
        productUpdateDate: Formatter.dateFormat(),
      )
    );
  });

final productsFutureProvider = FutureProvider.autoDispose<List<Product>>((ref) async{
      return await ProductUseCase(ProductFirestore()).getAllProducts();
},);

final productStreamProvider = StreamProvider.autoDispose.family<Product?, String>((ref, idProduct) async*{
      await for( final product in ProductUseCase(ProductFirestore()).getProduct(idProduct)){
        yield product;
      }
},);

class ProductNotifier extends StateNotifier <Product>{

  final ProductUseCase _productService = ProductUseCase(ProductFirestore());
  final PhotoUseCase _storageService = PhotoUseCase(PhotoStorage());
  List <ProductSize> sizes =[];

  ProductNotifier(super.state);

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


  Future <bool> addProduct(XFile? photo, List <Map<String, TextEditingController>> controllerSizes) async {

    state.id = state.reference + state.pinta;
    state.pinta = state.pinta.length == 1 ? 'P0${state.pinta}': 'P${state.pinta}';

    //FORMATTER sizes AND ADD STATE PRODUCT VALIDATE
    state.state = formatterSizes(controllerSizes) > 0 ? Strings.productAvailable : Strings.productNotAvailable;

    if(photo != null && state.id != null){
      //ADD PHOTO
      String photoPath  = await _storageService.uploadPhoto(CollectionStorage.products, state.id! , photo );
      String photoURL = await _storageService.downloadURL(photoPath);
      state.photoPath = photoPath;
      state.photoURL = photoURL;
      //ADD PRODUCT
      await _productService.addProduct(state);
      //ADD PRODUCT SIZES
      await _productService.addSizesOfProduct(state.id!, sizes);
      return true;
    }
  
    return false;

  }
  
  Future <bool> updateProduct(XFile? photo, List <Map<String, TextEditingController>> controllerSizes) async {
    
    bool validate = true;
    
    if(photo != null){
      //UPDATE PHOTO
      await _storageService.deletePhoto(state.photoPath);
      String photoPath  = await _storageService.uploadPhoto(CollectionStorage.products, state.id! , photo );
      String photoURL = await _storageService.downloadURL(photoPath);
      state.photoPath = photoPath;
      state.photoURL = photoURL;
    }
    //Add ID PRODUCT
    state.id = state.reference + state.pinta;
    //FORMATTER sizes AND ADD STATE PRODUCT VALIDATE
    state.state = formatterSizes(controllerSizes) > 0 ? Strings.productAvailable : Strings.productNotAvailable;
    //FORMATTER Site
    state.site = state.site.replaceAll('${Strings.siteProduct} ', '');
    //UPDATE PRODUCT SIZES
    await _productService.updateSizesOfProduct(state.id!, sizes);
    //UPDATE PRODUCT
    await _productService.updateProduct(state);

    return true;
  }

  Future <bool> deleteProduct(Product product) async{
    await _storageService.deletePhoto(product.photoPath);
    return await _productService.deleteProduct(product.id!);
  }

}