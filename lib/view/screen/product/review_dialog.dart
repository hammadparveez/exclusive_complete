import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/body/review_body.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_loader.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_textfield.dart';
import 'package:provider/provider.dart';

class ReviewDialog extends StatefulWidget {
  final String productID;
  ReviewDialog({@required this.productID});

  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [

          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.cancel, color: ColorResources.RED),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          Text(Strings.review_your_experience, style: titilliumRegular),
          Divider(height: 5),

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Row(children: [
              Expanded(child: Text(Strings.your_rating, style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL))),
              Container(
                height: 30,
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorResources.LOW_GREEN,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Icon(
                        Icons.star,
                        size: 20,
                        color: Provider.of<ProductDetailsProvider>(context).rating < (index+1) ? ColorResources.WHITE
                            : ColorResources.YELLOW,
                      ),
                      onTap: () => Provider.of<ProductDetailsProvider>(context, listen: false).setRating(index+1),
                    );
                  },
                ),
              ),
            ]),
          ),

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: CustomTextField(
              maxLine: 5,
              hintText: Strings.write_your_experience_here,
              controller: _controller,
              textInputAction: TextInputAction.done,
              fillColor: ColorResources.LOW_GREEN,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Row(children: [
              Expanded(child: Text(Strings.upload_images, style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL))),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: 100,
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Icon(Icons.cloud_upload_outlined, color: ColorResources.COLUMBIA_BLUE),
                      CustomPaint(
                        size: Size(100, 40),
                        foregroundPainter: new MyPainter(completeColor: ColorResources.COLUMBIA_BLUE, width: 2),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),

          Provider.of<ProductDetailsProvider>(context).errorText != null ? Text(Provider.of<ProductDetailsProvider>(context).errorText,
              style: titilliumRegular.copyWith(color: ColorResources.RED)) : SizedBox.shrink(),

          Builder(
            builder: (context) => !Provider.of<ProductDetailsProvider>(context).isLoading ? Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              child: CustomButton(
                buttonText: Strings.submit,
                onTap: () {
                  if(Provider.of<ProductDetailsProvider>(context, listen: false).rating == 0) {
                    Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText('Add a rating');
                  }else if(_controller.text.isEmpty) {
                    Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText('Write something');
                  }else {
                    ReviewBody reviewBody = ReviewBody(
                      productId: widget.productID,
                      rating: Provider.of<ProductDetailsProvider>(context, listen: false).rating.toString(),
                      comment: _controller.text.isEmpty ? '' : _controller.text,
                    );
                    Provider.of<ProductDetailsProvider>(context, listen: false).submitReview(reviewBody).then((value) {
                      if(value.isSuccess) {
                        Navigator.pop(context);
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        _controller.clear();

                        //showCustomSnackBar(value.message, context, isError: false);
                      }else {
                        Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText(value.message);
                      }
                    });
                  }
                },
              ),
            ) : Center(child: CustomLoader(
              color: ColorResources.COLOR_PRIMARY,
              size: 40,
              duration: Duration(milliseconds: 1200),
            )),
          ),

        ]),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Color lineColor =  Colors.transparent;
  Color completeColor;
  double width;
  MyPainter({this.completeColor, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    var percent = (size.width *0.001) / 2;
    double arcAngle = 2 * pi * percent;

    for (var i = 0; i < 8; i++) {
      var init = (-pi / 2)*(i/2);
      canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), init, arcAngle, false, complete);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
