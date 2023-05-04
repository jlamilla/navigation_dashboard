
import 'package:navigation_dashboard/domain/models/product/repository/product_repository.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';

class ProductUseCase{
  final ProductRepository _productRepository;
  ProductUseCase(this._productRepository);
  Future addProduct(Product product) => _productRepository.addProduct(product);
  Future <List<Product>> getAllProducts() => _productRepository.getProducts();
  Stream <Product?> getProduct(String idProduct) => _productRepository.getProduct(idProduct);
  Future updateProduct(Product product) => _productRepository.updateProduct(product);
  Future deleteProduct(String idProduct) => _productRepository.deleteProduct(idProduct);
  Future addSizesOfProduct(String idProduct,List<ProductSize> sizes) => _productRepository.addSizes(idProduct, sizes);
  Stream <ProductSize?> getSizesOfProduct(String idProduct) => _productRepository.getSizes(idProduct);
  Future <List<ProductSize?>> getSizesOfProductEdit(String idProduct) => _productRepository.getSizesEdit(idProduct);
  Stream <ProductSize?> getSizeOfProduct(String idProduct, String size) => _productRepository.getSize(idProduct, size);
  Future <ProductSize?> getSizeOfProductEdit(String idProduct, String size) => _productRepository.getSizeEdit(idProduct, size);
  Future updateSizesOfProduct(String idProduct, List<ProductSize> sizes) => _productRepository.updateSizes(idProduct, sizes);
  Future updateSizeOfProduct(String idProduct, ProductSize size) => _productRepository.updateSize(idProduct, size);
}