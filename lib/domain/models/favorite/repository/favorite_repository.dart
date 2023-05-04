import 'package:navigation_dashboard/domain/models/favorite/favorite_model.dart';

abstract class FavoriteRepository {
  Future addFavorite(Favorite favoriteProduct, String userId);
  Stream <List<Favorite?>> getFavorites(String userId);
  Future <Favorite> getFavorite(String userId, String favoriteId);
  Future deleteFavorite(String userId, String favoriteId);
}