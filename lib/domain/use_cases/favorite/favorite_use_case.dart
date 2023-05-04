import 'package:navigation_dashboard/domain/models/favorite/favorite_model.dart';

import '../../models/favorite/repository/favorite_repository.dart';

class FavoriteUseCase {
  final FavoriteRepository _favoriteRepository;
  FavoriteUseCase(this._favoriteRepository);
  
  Future addUserFavoriteProduct(Favorite favoriteProduct, String userId) => _favoriteRepository.addFavorite(favoriteProduct, userId);
  Stream <List<Favorite?>> getUserFavoriteProducts(String userId) => _favoriteRepository.getFavorites(userId);
  Future <Favorite> getUserFavoriteProduct(String userId, String favoriteId) => _favoriteRepository.getFavorite(userId,favoriteId);
  Future deleteUserFavoriteProduct(String userId, String favoriteId) => _favoriteRepository.deleteFavorite(userId,favoriteId);
}