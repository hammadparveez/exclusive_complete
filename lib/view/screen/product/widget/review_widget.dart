import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/review_model.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel reviewModel;
  ReviewWidget({@required this.reviewModel});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            reviewModel.customer.image,
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 5),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(
              '${reviewModel.customer.fName} ${reviewModel.customer.lName}',
              style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 5),
            RatingBar(rating: double.parse(reviewModel.rating), size: 12),
          ]),
          Text(reviewModel.updatedAt, style: titilliumRegular.copyWith(
            color: ColorResources.HINT_TEXT_COLOR,
            fontSize: 6,
          )),
        ]),
      ]),

      SizedBox(height: 5),

      Text(reviewModel.comment, style:
      titilliumRegular.copyWith(color: ColorResources.HINT_TEXT_COLOR, fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
      ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }
}

class ReviewShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: Provider.of<ProductDetailsProvider>(context).reviewList == null,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(
            maxRadius: 15,
            backgroundColor: ColorResources.SELLER_TXT,
            child: Icon(Icons.person),
          ),
          SizedBox(width: 5),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(height: 10, width: 50, color: ColorResources.WHITE),
              SizedBox(width: 5),
              RatingBar(rating: 0, size: 12),
            ]),
            Container(height: 10, width: 50, color: ColorResources.WHITE),
          ]),
        ]),
        SizedBox(height: 5),
        Container(height: 20, width: 200, color: ColorResources.WHITE),
      ]),
    );
  }
}

