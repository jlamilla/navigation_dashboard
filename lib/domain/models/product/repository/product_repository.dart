import 'package:navigation_dashboard/domain/models/product/product_model.dart';

abstract class ProductRepository {
  Future addProduct(Product product);
  Future <List<Product>> getProducts();
  Stream <Product?> getProduct(String idProduct);
  Future updateProduct(Product product);
  Future deleteProduct(String idProduct);
  Future addSizes(String idProduct,List<ProductSize> sizes);
  Stream <ProductSize?> getSizes(String idProduct);
  Future <List<ProductSize?>> getSizesEdit(String idProduct);
  Stream <ProductSize?> getSize(String idProduct, String size);
  Future <ProductSize?> getSizeEdit(String idProduct, String size);
  Future updateSizes(String idProduct, List<ProductSize> sizes);
  Future updateSize(String idProduct, ProductSize size);
}