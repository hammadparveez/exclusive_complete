import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Shimmer.fromColors(
            child: Container(
                height: Get.height / 40,
                width: Get.width - 10,
                color: Colors.black12),
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
          ),
          Shimmer.fromColors(
            child: Container(height: 100, width: Get.width - 10),
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
          ),
          Shimmer.fromColors(
            child: Container(height: 120, width: Get.width - 10),
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
          ),
          Shimmer.fromColors(
            child: Container(height: Get.height / 30, width: Get.width - 10),
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
          ),
        ],
      ),
    );
  }
}
