import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';

class ProductImageScreen extends StatefulWidget {
  final ImagesModel imgModel;
  ProductImageScreen({@required this.imgModel});

  @override
  _ProductImageScreenState createState() => _ProductImageScreenState();
}

class _ProductImageScreenState extends State<ProductImageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          CustomAppBar(title: "Back"),
          Expanded(
            child: Hero(
              tag: 'image-view',
              child: GestureDetector(
                onTap: () {
                  Scaffold(
                      body: CachedNetworkImage(
                    imageUrl: widget.imgModel.src,
                    width: Get.width,
                    height: Get.height,
                  ));
                },
                child: CachedNetworkImage(
                  imageUrl: widget.imgModel.src,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
