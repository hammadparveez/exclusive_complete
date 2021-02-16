import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_ui_kit/provider/banner_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:url_launcher/url_launcher.dart';

class BannersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BannerProvider>(context, listen: false).initBannerList();
    });

    return Consumer<BannerProvider>(
      builder: (context, bannerProvider, child) {
        return Container(
          width: double.infinity,
          height: Get.height / 4.5,
          child: bannerProvider.bannerList != null
              ? bannerProvider.bannerList.length != 0
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        CarouselSlider.builder(
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              Provider.of<BannerProvider>(context,
                                      listen: false)
                                  .setCurrentIndex(index);
                            },
                          ),
                          itemCount: bannerProvider.bannerList.length == 0
                              ? 1
                              : bannerProvider.bannerList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              /*    onTap: () => _launchUrl(
                                  bannerProvider.bannerList[index].url),*/
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        blurRadius: 10,
                                        spreadRadius: 1)
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    bannerProvider.bannerList[index].photo,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 5,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: bannerProvider.bannerList.map((banner) {
                              int index =
                                  bannerProvider.bannerList.indexOf(banner);
                              return TabPageSelectorIndicator(
                                backgroundColor:
                                    index == bannerProvider.currentIndex
                                        ? Colors.black45
                                        : ColorResources.WHITE,
                                borderColor:
                                    index == bannerProvider.currentIndex
                                        ? Colors.white
                                        : Colors.black,
                                size: 10,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    )
                  : Center(child: Text('No banner available'))
              : Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  enabled: bannerProvider.bannerList == null,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorResources.WHITE,
                      )),
                ),
        );
      },
    );
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
