import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_model.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/order_provider.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_scroll_loader.dart';
import 'package:sixvalley_ui_kit/view/basewidget/not_loggedin_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/order/widget/order_widget.dart';

class OrderScreen extends StatefulWidget {
  final bool isBacButtonExist;
  final isOrderDone;
  OrderScreen({this.isBacButtonExist = true, this.isOrderDone = false});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int pageCounter = 1;
  int onHoldCounter = 1;
  int onPendingCounter = 1;
  int onCompletedCounter = 1;
  int onCancelledCounter = 1;
  int onProcessingCounter = 1;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageCounter = 1;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OrderProvider>(context, listen: false).isLoading = true;
      Provider.of<OrderProvider>(context, listen: false).pendingFetched = false;
      Provider.of<OrderProvider>(context, listen: false).onHoldFetched = false;
      Provider.of<OrderProvider>(context, listen: false).onCompleteFetched =
          false;
      Provider.of<OrderProvider>(context, listen: false).onProcessingFetched =
          false;
      Provider.of<OrderProvider>(context, listen: false).emptyAllList();
      Provider.of<OrderProvider>(context, listen: false).isOrdersLoaded = 1;
      /*     Provider.of<OrderProvider>(context, listen: false)
          .initOrderList(pageCount: pageCounter);*/
      Provider.of<OrderProvider>(context, listen: false).initOrdersByStatus(
          status: AppConstants.ON_HOLD, pageCount: onHoldCounter);
      Provider.of<OrderProvider>(context, listen: false).initOrdersByStatus(
          status: AppConstants.COMPLETED, pageCount: onCompletedCounter);
      Provider.of<OrderProvider>(context, listen: false).initOrdersByStatus(
          status: AppConstants.CANCELLED, pageCount: onCancelledCounter);
      Provider.of<OrderProvider>(context, listen: false).initOrdersByStatus(
          status: AppConstants.PENDING, pageCount: onPendingCounter);
      Provider.of<OrderProvider>(context, listen: false).initOrdersByStatus(
          status: AppConstants.PROCESSING, pageCount: onProcessingCounter);
    });
    _scrollController.addListener(() {
      final max = _scrollController.position.maxScrollExtent;
      final offSet = _scrollController.offset;
      if (offSet == max) {
        int count = ++pageCounter;

        final orderProvider =
            Provider.of<OrderProvider>(context, listen: false);

        if (orderProvider.orderTypeIndex == 0) {
          print("Order Loaded ${orderProvider.pendingFetched}");
          print(
              "Page Counter $count and Selected Index: ${orderProvider.orderTypeIndex} and ${orderProvider.pendingList.length}");
          if (!orderProvider.pendingFetched) {
            print(
                "Page Counter $count and Selected Index: ${orderProvider.orderTypeIndex} and ${orderProvider.pendingList.length}");
            Provider.of<OrderProvider>(context, listen: false)
                .isLoadingOnScroll = true;
            Provider.of<OrderProvider>(context, listen: false)
                .initOrdersByStatus(
                    status: AppConstants.PENDING,
                    pageCount: ++onPendingCounter);
          } else {
            Provider.of<OrderProvider>(context, listen: false)
                .isLoadingOnScroll = false;
          }
        } else if (orderProvider.orderTypeIndex == 1) {
          count = 1;
          print(
              "Page Counter $count and Selected Index: ${orderProvider.orderTypeIndex} and ${orderProvider.deliveredList.length}");
          if (!orderProvider.onCompleteFetched) {
            Provider.of<OrderProvider>(context, listen: false)
                .isLoadingOnScroll = true;
            Provider.of<OrderProvider>(context, listen: false)
                .initOrdersByStatus(
                    status: AppConstants.COMPLETED,
                    pageCount: ++onCompletedCounter);
          } else {
            Provider.of<OrderProvider>(context, listen: false)
                .isLoadingOnScroll = false;
          }
        } else if (orderProvider.orderTypeIndex == 2) {
          count = 1;
          print(
              "Page Counter $count and Selected Index: ${orderProvider.orderTypeIndex} and ${orderProvider.deliveredList.length}");
          if (!orderProvider.onCancelledFetched) {
            Provider.of<OrderProvider>(context, listen: false)
                .isLoadingOnScroll = true;
            Provider.of<OrderProvider>(context, listen: false)
                .initOrdersByStatus(
                    status: AppConstants.CANCELLED,
                    pageCount: ++onCancelledCounter);
          } else {
            Provider.of<OrderProvider>(context, listen: false)
                .isLoadingOnScroll = false;
          }
        } else if (orderProvider.orderTypeIndex == 3) {
          count = 1;
          print(
              "Page Counter $count and Selected Index: ${orderProvider.orderTypeIndex} and ${orderProvider.deliveredList.length}");
          if (!orderProvider.onProcessingFetched) {
            Provider.of<OrderProvider>(context, listen: false)
                .isLoadingOnScroll = true;
            Provider.of<OrderProvider>(context, listen: false)
                .initOrdersByStatus(
                    status: AppConstants.PROCESSING,
                    pageCount: ++onProcessingCounter);
          } else {
            Provider.of<OrderProvider>(context, listen: false)
                .isLoadingOnScroll = false;
          }
        } else if (orderProvider.orderTypeIndex == 4) {
          count = 1;
          print(
              "Page Counter $count and Selected Index: ${orderProvider.orderTypeIndex} and ${orderProvider.deliveredList.length}");
          if (!orderProvider.onHoldFetched) {
            Provider.of<OrderProvider>(context, listen: false)
                .isLoadingOnScroll = true;
            Provider.of<OrderProvider>(context, listen: false)
                .initOrdersByStatus(
                    status: AppConstants.ON_HOLD, pageCount: ++onHoldCounter);
          } else {
            Provider.of<OrderProvider>(context, listen: false)
                .isLoadingOnScroll = false;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        "Order P List Are ${Provider.of<OrderProvider>(context).pendingList}");
    print(
        "Order C List Are ${Provider.of<OrderProvider>(context).canceledList}");
    print(
        "Order D List Are ${Provider.of<OrderProvider>(context).deliveredList}");
    print("Order O List Are ${Provider.of<OrderProvider>(context).onHoldList}");
    return RefreshIndicator(
      displacement: Get.height * .2,
      onRefresh: () async {
        String status = "";
        final orderProvider =
            Provider.of<OrderProvider>(context, listen: false);
        if (orderProvider.orderTypeIndex == 0)
          status = AppConstants.PENDING;
        else if (orderProvider.orderTypeIndex == 1)
          status = AppConstants.COMPLETED;
        else if (orderProvider.orderTypeIndex == 2)
          status = AppConstants.CANCELLED;
        else if (orderProvider.orderTypeIndex == 3)
          status = AppConstants.PROCESSING;
        else if (orderProvider.orderTypeIndex == 4)
          status = AppConstants.ON_HOLD;
        print("My Status $status");

        Provider.of<OrderProvider>(context, listen: false)
            .resetList(orderProvider.orderTypeIndex);
        await Provider.of<OrderProvider>(context, listen: false)
            .initOrdersByStatus(status: status, pageCount: 1);
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorResources.ICON_BG,
        body: Consumer2<AuthProvider, OrderProvider>(
          builder: (_, authProvider, orderProvider, child) => Column(
            children: [
              CustomAppBar(
                  isOrderDone: widget.isOrderDone,
                  title: Strings.ORDER,
                  isBackButtonExist: widget.isBacButtonExist),
              !authProvider.isInvalidAuth | orderProvider.isLoading
                  ? SizedBox()
                  : Provider.of<OrderProvider>(context, listen: false)
                              .pendingList !=
                          null
                      ? Consumer<OrderProvider>(
                          builder: (context, orderProvider, child) => Padding(
                            padding:
                                EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  OrderTypeButton(
                                      text: Strings.PENDING,
                                      index: 0,
                                      onPress: () => onPressBtn(
                                          context: context, index: 0),
                                      orderList: orderProvider.pendingList),
                                  SizedBox(width: 10),
                                  OrderTypeButton(
                                      text: Strings.DELIVERED,
                                      index: 1,
                                      onPress: () => onPressBtn(
                                          context: context, index: 1),
                                      orderList: orderProvider.deliveredList),
                                  SizedBox(width: 10),
                                  OrderTypeButton(
                                      text: Strings.CANCELED,
                                      index: 2,
                                      onPress: () => onPressBtn(
                                          context: context, index: 2),
                                      orderList: orderProvider.canceledList),
                                  OrderTypeButton(
                                      text: Strings.PROCESSING,
                                      index: 3,
                                      onPress: () => onPressBtn(
                                          context: context, index: 3),
                                      orderList: orderProvider.processingList),
                                  SizedBox(width: 10),
                                  OrderTypeButton(
                                      text: Strings.ON_HOLD,
                                      index: 4,
                                      onPress: () => onPressBtn(
                                          context: context, index: 4),
                                      orderList: orderProvider.onHoldList),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
              !authProvider.isInvalidAuth
                  ? NotLoggedInWidget()
                  : CustomLoader(isLoading: orderProvider.isLoading,
                      elseWidget: Provider.of<OrderProvider>(context, listen: false)
                                  .pendingList !=
                              null
                          ? Consumer<OrderProvider>(
                              builder: (context, order, child) {
                                List<OrderModel> orderList = [];
                                if (Provider.of<OrderProvider>(context,
                                            listen: false)
                                        .orderTypeIndex ==
                                    0) {
                                  orderList = order.pendingList;
                                } else if (Provider.of<OrderProvider>(context,
                                            listen: false)
                                        .orderTypeIndex ==
                                    1) {
                                  orderList = order.deliveredList;
                                } else if (Provider.of<OrderProvider>(context,
                                            listen: false)
                                        .orderTypeIndex ==
                                    2) {
                                  orderList = order.canceledList;
                                } else if (Provider.of<OrderProvider>(context,
                                            listen: false)
                                        .orderTypeIndex ==
                                    3) {
                                  orderList = order.processingList;
                                } else if (Provider.of<OrderProvider>(context,
                                            listen: false)
                                        .orderTypeIndex ==
                                    4) {
                                  orderList = order.onHoldList;
                                }

                                return Expanded(
                                  child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(
                                          parent: BouncingScrollPhysics()),
                                      controller: _scrollController,
                                      itemCount: orderList.length,
                                      padding: EdgeInsets.all(0),
                                      itemBuilder: (context, index) {
                                        if (orderList[index].shipping != null)
                                          return OrderWidget(
                                              orderModel: orderList[index]);
                                        else
                                          return const SizedBox.shrink();
                                      }),
                                );
                              },
                            )
                          : Expanded(child: OrderShimmer())
        ),
         /*             : Expanded(
                          child: Center(child: CircularProgressIndicator())),*/
              CustomScrollLoader(isLoading: orderProvider.isLoadingOnScroll),
            ],
          ),
        ),
      ),
    );
  }

  onPressBtn({BuildContext context, int index}) {
    Provider.of<OrderProvider>(context, listen: false).setIndex(index);
    setState(() {
      pageCounter = 0;
    });
  }
}

class OrderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_DEFAULT),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          color: ColorResources.WHITE,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 150, color: ColorResources.WHITE),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child:
                            Container(height: 45, color: ColorResources.WHITE)),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(height: 20, color: ColorResources.WHITE),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                  height: 10,
                                  width: 70,
                                  color: ColorResources.WHITE),
                              SizedBox(width: 10),
                              Container(
                                  height: 10,
                                  width: 20,
                                  color: ColorResources.WHITE),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OrderTypeButton extends StatelessWidget {
  final String text;
  final int index;
  final Function onPress;
  final List<OrderModel> orderList;

  OrderTypeButton(
      {@required this.text,
      @required this.index,
      @required this.orderList,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      //Provider.of<OrderProvider>(context, listen: false).setIndex(index),
      padding: EdgeInsets.zero,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Provider.of<OrderProvider>(context, listen: false)
                      .orderTypeIndex ==
                  index
              ? ColorResources.COLOR_PRIMARY
              : ColorResources.WHITE,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('$text',
              style: titilliumBold.copyWith(
                  color: Provider.of<OrderProvider>(context, listen: false)
                              .orderTypeIndex ==
                          index
                      ? ColorResources.WHITE
                      : ColorResources.COLOR_PRIMARY)),
        ),
      ),
    );
  }
}
