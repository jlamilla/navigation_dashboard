import 'package:navigation_dashboard/domain/models/banner/banner_model.dart';
import 'package:navigation_dashboard/domain/models/banner/repository/banner_repository.dart';

class BannerUseCase{
  final BannerRepository _bannerRepository;
  BannerUseCase(this._bannerRepository);
  Future addBanner (Banner banner) => _bannerRepository.addBanner(banner);
  Future <List<Banner?>> getBanners () => _bannerRepository.getBanners();
  Future <Banner?> getBanner (String bannerId) => _bannerRepository.getBanner(bannerId);
  Future updateBanner (Banner banner) => _bannerRepository.updateBanner(banner);
  Future deleteBanner (String bannerId) => _bannerRepository.deleteBanner(bannerId);
}