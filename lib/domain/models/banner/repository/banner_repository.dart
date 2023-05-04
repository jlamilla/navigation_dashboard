import 'package:navigation_dashboard/domain/models/banner/banner_model.dart';

abstract class BannerRepository {
  Future addBanner(Banner banner);
  Future <List<Banner?>> getBanners();
  Future <Banner?> getBanner(String bannerId);
  Future updateBanner(Banner banner);
  Future deleteBanner(String bannerId);
}