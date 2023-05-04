import 'package:navigation_dashboard/domain/models/product/product_model.dart';

abstract class AnalyticDataRepository {
  Future <int> getUserCount();
  Future <int> getOrdersCount();
  Future <int> getProductsCount();
  Future <Product?> getBestSellingProduct();
}