import 'package:sixvalley_ui_kit/data/model/response/banner_model.dart';

class BannerRepo {
  List<BannerModel> getBannerList() {
    List<BannerModel> bannerList = [
      BannerModel(
          id: 1,
          photo: 'assets/product_images/Updated.jpg',
          url: 'https://www.facebook.com'),
      BannerModel(
          id: 2,
          photo: 'assets/product_images/Kurti.jpg',
          url: 'https://www.facebook.com'),
      BannerModel(
          id: 3,
          photo: 'assets/product_images/banner_inner_party-1.jpg',
          url: 'https://www.facebook.com'),
    ];
    return bannerList;
  }
}
