import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:navigation_dashboard/domain/models/banner/banner_model.dart';
import 'package:navigation_dashboard/domain/models/banner/repository/banner_repository.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/banner/error/banner_db_error.dart';
import 'package:navigation_dashboard/infrastructure/helpers/collections.dart';

class BannerFirestore extends BannerRepository{
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future addBanner(Banner banner) async{
    try{
      await _firestore.collection(Collections.slider).doc().set(banner.toMap());
    }catch (e){
      log(e.toString());
      throw AddBannerDbError();
    }
  }
  
  @override
  Future <Banner?> getBanner(String bannerId) async{
    try{
      final bannerData = await _firestore.collection(Collections.slider).doc(bannerId).get();
      return Banner.fromMap(bannerData.data()!);
    }catch (e){
      log(e.toString());
      throw GetBannerDbError();
    }
  }
  
  @override
  Future <List<Banner?>> getBanners() async{
    List<Banner> banners = [];
    try{
      final bannersData = await _firestore.collection(Collections.slider).get();
      for(var banner in bannersData.docs){
        banners.add(Banner.fromMap(banner.data()));
      }
    }catch (e){
      log(e.toString());
      throw GetBannersDbError();
    }
    return banners;
  }
  
  @override
  Future updateBanner(Banner banner) async{
    try{
      await _firestore.collection(Collections.slider).doc().update(banner.toMap());
    }catch (e){
      log(e.toString());
      throw UpdateBannerDbError();
    }
  }

  @override
  Future deleteBanner(String bannerId) async{
    try{
      await _firestore.collection(Collections.slider).doc(bannerId).delete();
    }catch (e){
      log(e.toString());
      throw DeleteBannerDbError();
    }
  }

}