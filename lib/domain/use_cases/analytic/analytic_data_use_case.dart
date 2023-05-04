import 'package:navigation_dashboard/domain/models/analytic/repository/analytic_repository.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';

class AnalyticDataUseCase {
  final AnalyticDataRepository _analyticDataRepository;
  AnalyticDataUseCase(this._analyticDataRepository);

  Future <int> getUserCount() => _analyticDataRepository.getUserCount();
  Future <int> getOrdersCount() => _analyticDataRepository.getOrdersCount();
  Future <int> getProductsCount() => _analyticDataRepository.getProductsCount();
  Future <Product?> getBestSellingProduct() => _analyticDataRepository.getBestSellingProduct();
}