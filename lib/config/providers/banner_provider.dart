import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/domain/use_cases/banner/banner_use_case.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/banner/banner_db.dart';

final bannerProvider = Provider<BannerUseCase>((ref) {
  return  BannerUseCase(BannerFirestore());
});