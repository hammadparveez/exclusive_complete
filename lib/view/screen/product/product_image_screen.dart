import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';

class ProductImageScreen extends StatefulWidget {
  final ImagesModel imgModel;
  ProductImageScreen({@required this.imgModel});

  @override
  _ProductImageScreenState createState() => _ProductImageScreenState();
}

class _ProductImageScreenState extends State<ProductImageScreen> {
  double zoom = 0.3;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
       /* setState(() {
          zoom = 4;
        });*/
        return true;
      },
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            CustomAppBar(title: "Back"),
            Expanded(
              child: Hero(
                tag: 'image-view',
                child: GestureDetector(
                  onTap: () {
                    SystemChrome.setEnabledSystemUIOverlays([]);
                    showDialog(
                      context: context,
                      builder: (_) => WillPopScope(
                        onWillPop: () async {
                          SystemChrome.setEnabledSystemUIOverlays(
                              SystemUiOverlay.values);
                          return true;
                        },
                        child: InteractiveViewer(
                          maxScale: 4,
                          minScale: zoom,
                          scaleEnabled: true,
                          child: Container(
                            // width: Get.width,
                            //height: Get.height,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(widget.imgModel.src),
                                  fit: BoxFit.cover,
                                  onError: (e, error) {
                                    showCustomSnackBar(
                                        "Image not available", context);
                                  }),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: InteractiveViewer(
                    scaleEnabled: true,
                    minScale: 0.3,
                    maxScale: 4,
                    child: CachedNetworkImage(
                      imageUrl: widget.imgModel.src,
                      placeholder: (_, str) {
                        return SpinKitFadingCircle(color: Colors.transparent);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
