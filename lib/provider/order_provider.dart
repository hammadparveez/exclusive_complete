import 'package:flutter/cupertino.dart';
import 'package:sixvalley_ui_kit/data/model/body/order_place_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_details.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/shipping_method_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_customer_model.dart';
import 'package:sixvalley_ui_kit/data/repository/order_repo.dart';
import 'package:sixvalley_ui_kit/data/shipping_update_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class OrderProvider with ChangeNotifier {
  final OrderRepo orderRepo;
  OrderProvider({@required this.orderRepo});

  List<OrderModel> _pendingList;
  List<OrderModel> _allOrders = [];
  List<OrderModel> _deliveredList;
  List<OrderModel> _canceledList;
  List<OrderModel> _onHoldList;

  List<OrderModel> get onHoldList => _onHoldList;
  List<OrderModel> _processingList;
  int _addressIndex;
  int _shippingIndex;
  bool _isLoading = false;
  bool _isLoadingOnScroll = false;
  bool _pendingFetched = false,
      _onHoldFetched = false,
      _onCompleteFetched = false,
      _onProcessingFetched = false,
      _onCancelledFetched = false;

  bool get onCancelledFetched => _onCancelledFetched;

  set onCancelledFetched(value) {
    _onCancelledFetched = value;
    notifyListeners();
  }

  bool get pendingFetched => _pendingFetched;

  set pendingFetched(bool value) {
    _pendingFetched = value;
    notifyListeners();
  }

  bool get isLoadingOnScroll => _isLoadingOnScroll;

  set isLoadingOnScroll(bool value) {
    _isLoadingOnScroll = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<ShippingMethodModel> _shippingList;
  bool hasOrderPlaced = false;
  bool _isSelected = false;
  int _isOrdersLoaded = 1;

  int get isOrdersLoaded => _isOrdersLoaded;

  set isOrdersLoaded(int value) {
    _isOrdersLoaded = value;
    notifyListeners();
  }

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
    notifyListeners();
  }

  void emptyAllList() {
    _pendingList = [];
    _deliveredList = [];
    _canceledList = [];
    _onHoldList = [];
    _processingList = [];
    notifyListeners();
  }

  List<OrderModel> get pendingList => _pendingList;
  List<OrderModel> get deliveredList => _deliveredList;
  List<OrderModel> get canceledList => _canceledList;
  int get addressIndex => _addressIndex;
  int get shippingIndex => _shippingIndex;
  bool get isLoading => _isLoading;
  List<ShippingMethodModel> get shippingList => _shippingList;

  Future<void> initOrderList({int pageCount = 1}) async {
    final orders = await orderRepo.getOrdersByUserID(pageCount: pageCount);
    print("All Orders ${orders.length}");
    orders.forEach((element) {
      print("Orders are ${element.listOfLineItems.length}");
    });

    orders.forEach((order) {
      print("Order Status Check: ${order.orderStatus}");
      OrderModel orderModel = order;
      print(
          "Order State ${AppConstants.CANCELLED.contains(orderModel.orderStatus)}");
      if (AppConstants.PENDING.contains(orderModel.orderStatus)) {
        print(" My Pending");
        _pendingList.add(orderModel);
      } else if (AppConstants.COMPLETED.contains(orderModel.orderStatus)) {
        print(" My Completed");

        _deliveredList.add(orderModel);
      } else if (AppConstants.CANCELLED.contains(orderModel.orderStatus)) {
        print(" My Cancelled");
        _canceledList.add(orderModel);
      } else if (AppConstants.PROCESSING.contains(orderModel.orderStatus)) {
        print(" My Processing");
        _processingList.add(orderModel);
      } else if (AppConstants.ON_HOLD.contains(orderModel.orderStatus)) {
        print(" My On Hold");
        _onHoldList.add(orderModel);
      }
    });
    _isLoading = false;
    notifyListeners();
  }

  int _orderTypeIndex = 0;
  int get orderTypeIndex => _orderTypeIndex;

  void setIndex(int index) {
    _orderTypeIndex = index;
    notifyListeners();
  }

  List<OrderDetailsModel> _orderDetails;
  List<OrderDetailsModel> get orderDetails => _orderDetails;

  void getOrderDetails() async {
    _orderDetails = [];

    orderRepo.getOrderDetails().forEach((order) => _orderDetails.add(order));
    notifyListeners();
  }

  initOrdersByStatus({int pageCount, String status}) async {
    _isOrdersLoaded = 1;
    final orders =
        await orderRepo.getOrdersByUserID(pageCount: pageCount, status: status);
    print("Orders Length Checker ${orders.length}");
    //if (orders.isNotEmpty) {
    //Pending Orders
    if (AppConstants.PENDING.contains(status)) {
      print("Orders Pending");
      if (orders.isNotEmpty) {
        _pendingList.addAll(orders);
      } else
        _pendingFetched = true;
      _isLoadingOnScroll = false;
    }
    //On Hold Orders
    else if (AppConstants.ON_HOLD.contains(status)) {
      print("Orders Holding");
      if (orders.isNotEmpty)
        _onHoldList.addAll(orders);
      else {
        _onHoldFetched = true;
        print("All Fetched On Hold");
      }
      _isLoadingOnScroll = false;
    }
    //Completed Orders
    else if (AppConstants.COMPLETED.contains(status)) {
      print("Orders Completed");
      if (orders.isNotEmpty)
        _deliveredList.addAll(orders);
      else {
        _onCompleteFetched = true;
        print("All Fetched On Completed");
      }
      _isLoadingOnScroll = false;
    } else if (AppConstants.CANCELLED.contains(status)) {
      print("Orders Cancelled");
      if (orders.isNotEmpty)
        _canceledList.addAll(orders);
      else {
        _onCancelledFetched = true;
        print("All Fetched On Hold");
      }
      _isLoadingOnScroll = false;
    } else if (AppConstants.PROCESSING.contains(status)) {
      print("Orders Cancelled");
      if (orders.isNotEmpty)
        _processingList.addAll(orders);
      else {
        _onProcessingFetched = true;
        print("All Fetched On Hold");
      }
      _isLoadingOnScroll = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  void resetList(int index) {
    if (index == 0)
      _pendingList = [];
    else if (index == 1)
      _deliveredList = [];
    else if (index == 2)
      _canceledList = [];
    else if (index == 3)
      _processingList = [];
    else if (index == 4) _onHoldList = [];
  }

  Future<void> placeOrder(OrderPlaceModel orderPlaceModel, Function callback,
      List<CartModel> cartList) async {
    _addressIndex = null;
    callback(true, 'Order placed successfully', cartList);
    notifyListeners();
  }

  void setAddressIndex(int index) {
    _isSelected = true;
    _addressIndex = index;
    notifyListeners();
  }

  void initShippingList() async {
    _shippingList = [];
    orderRepo
        .getShippingList()
        .forEach((shippingMethod) => _shippingList.add(shippingMethod));
    notifyListeners();
  }

  void setSelectedShippingAddress(int index) {
    _shippingIndex = index;
    notifyListeners();
  }

  void addOrder(OrderModel orderModel) {
    orderRepo.addOrder(orderModel);
    notifyListeners();
  }

  Future<bool> makeOrder({
    @required int userID,
    @required List<CartModel> cartModel,
    String countryModel,
    BillingAddressModel billingAddressModel,
    String paymentType,
    String paymentTitle,
    String selectedCountryCode,
    ShippingUpdateModel shippingUpdateModel,
  }) async {
    print(
        "My Address ${billingAddressModel?.address_1} and ${billingAddressModel.address_2}");
    OrderModel order = await orderRepo.makeOrder(
        userID: userID,
        countryModel: countryModel,
        cartModel: cartModel,
        selectedCountryCode: selectedCountryCode,
        paymentType: paymentType,
        paymentTitle: paymentTitle,
        billingAddressModel: billingAddressModel,
        shippingUpdateModel: shippingUpdateModel);
    if (order != null) {
      hasOrderPlaced = true;
      orderRepo.addOrder(order);

      //addOrder(order);
    } else {
      hasOrderPlaced = false;
    }

    notifyListeners();
    print("Order Provider $hasOrderPlaced");
    return hasOrderPlaced;
  }

  List<OrderModel> get processingList => _processingList;

  get onHoldFetched => _onHoldFetched;

  set onHoldFetched(value) {
    _onHoldFetched = value;
    notifyListeners();
  }

  get onCompleteFetched => _onCompleteFetched;

  set onCompleteFetched(value) {
    _onCompleteFetched = value;
    notifyListeners();
  }

  get onProcessingFetched => _onProcessingFetched;

  set onProcessingFetched(value) {
    _onProcessingFetched = value;
    notifyListeners();
  }
}
