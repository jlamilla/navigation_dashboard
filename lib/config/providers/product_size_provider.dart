import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/domain/use_cases/product/product_use_case.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/product/product_db.dart';

final productSizeContinueProvider = StateProvider.autoDispose<bool>((ref) => false);
final productSizeControllerProvider = StateProvider.autoDispose<List<Map<String, TextEditingController>>>((ref) => []);
final productSizeSelectIndexProvider = StateProvider.autoDispose<List<int>>((ref) => []);

final productSizesStreamProvider = StreamProvider.autoDispose.family<ProductSize?, String>((ref, idProduct) async*{

    /*for (int i=0; i < sizesOriginal.length ;i++) {
      _controllersSizes.add(<String, dynamic> {
                        "size": TextEditingController(text:  sizesOriginal[i]!.size),
                        "amount": TextEditingController(text: sizesOriginal[i]!.amount.toString()),});
    }*/
    yield* ProductUseCase(ProductFirestore()).getSizesOfProduct(idProduct);
});

final productSizesFutureProvider = FutureProvider.autoDispose.family((ref, String idProduct) async{

    final List<ProductSize?> sizesOriginal =  await ProductUseCase(ProductFirestore()).getSizesOfProductEdit(idProduct);
    final sizesController = ref.watch(productSizeControllerProvider);
      for (int i=0; i < sizesOriginal.length ;i++) {
        sizesController.add(<String, TextEditingController> {
                        "size": TextEditingController(text:  sizesOriginal[i]!.size),
                        "amount": TextEditingController(text: sizesOriginal[i]!.amount.toString()),
        });
      }
    return sizesController;
});