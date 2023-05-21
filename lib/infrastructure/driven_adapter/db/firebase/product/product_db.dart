import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:navigation_dashboard/domain/models/product/repository/product_repository.dart';
import '../../../../../domain/models/product/product_model.dart';
import '../../../../helpers/collections.dart';
import 'errors/product_db_error.dart';

class ProductFirestore extends ProductRepository{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future addProduct(Product product) async{
    try{
      await _firestore.collection(Collections.products).doc(product.id).set(product.toMap());
    }catch(e){
      log(e.toString());
      throw ProductDbError();
    }
  }

  @override
  Future <List<Product>> getProducts() async{
    try{
      final products = <Product>[];
      final productsData = await _firestore.collection(Collections.products).get();
        for(final product in productsData.docs){
          final temp = Product.fromMap(product.data());
          temp.id = product.id;
          products.add(temp);
        }
      return products;
    }catch(e){
      log(e.toString());
      throw ProductDbError();
    }
  }

  @override
  Stream <Product?> getProduct(String idProduct) async*{
    try{
      await for(final sizeData in _firestore.collection(Collections.products).doc(idProduct).snapshots()){
        yield Product.fromMap(sizeData.data()!);
      }
    }catch(e){
      log(e.toString());
      throw ProductDbError();
    }
  }

  @override
  Future updateProduct(Product product) async{
    try {
      await _firestore.collection(Collections.products).doc(product.id).update(product.toMap());
    } catch (e) {
      log(e.toString());
      throw ProductDbError();
    }
  }

  @override
  Future deleteProduct(String idProduct) async{
    try{
      final sizes = await _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).get();
      for(var size in sizes.docs){
        await _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).doc(size.id).delete();
      }
      await _firestore.collection(Collections.products).doc(idProduct).delete();
    }catch(e){
      log(e.toString());
      throw ProductDbError();
    }
  }

  @override
  Future addSizes(String idProduct,List<ProductSize> sizes) async{
    try{
      for(ProductSize size in sizes){
        await _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).doc(idProduct+size.size).set(size.toMap());
      }
    }catch(e){
      log(e.toString());
      throw ProductDbError();
    }
  }

  @override
  Stream <ProductSize?> getSizes(String idProduct) async*{
    try{
      await for(final sizesData in _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).snapshots()){
        for(final size in sizesData.docs){
          yield ProductSize.fromMap(size.data());
        }
      }     
    }catch(e){
      log(e.toString());
      throw ProductDbError();
    }
  }

  @override
  Future<List<ProductSize?>> getSizesEdit(String idProduct) async{
    try{
      List<ProductSize?> sizes = [];
      final sizesData = await _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).get();
      for (var size in sizesData.docs) {
        sizes.add(ProductSize.fromMap(size.data()));
      }
      return sizes;
    }catch(e){
      log(e.toString());
      throw ProductDbError();
    }
  }

  @override
  Future<ProductSize?> getSizeEdit(String idProduct, String size) async{
    try{
      ProductSize? productSize;
      final sizesData = await _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).doc(idProduct+size).get();
      if(sizesData.data() != null){
        productSize = ProductSize.fromMap(sizesData.data()!);
      }
      return productSize;
    }catch(e){
      log(e.toString());
      throw ProductDbError();
    }
  }

  @override
  Stream <ProductSize?> getSize(String idProduct, String size) async*{
    try{
      await for(final sizeData in _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).doc(size).snapshots()){
        yield ProductSize.fromMap(sizeData.data()!);
      }
    }catch(e){
      log(e.toString());
      throw ProductDbError();
    }
  }

  @override
  Future updateSizes(String idProduct, List<ProductSize> sizes) async{
    try{
      for(ProductSize size in sizes){
        await _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).doc(idProduct+size.size).delete();
      }
      for(ProductSize size in sizes){
        await _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).doc(idProduct+size.size).set(size.toMap());
      }
    }catch(e){
      log(e.toString());
      throw ProductDbError();
    }
  }

  @override
  Future updateSize(String idProduct, ProductSize size) async{
    try{
      await _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).doc(idProduct+size.size).update(size.toMap());
    }catch(e){
      log(e.toString());
      throw ProductDbError();
    }
  }
}