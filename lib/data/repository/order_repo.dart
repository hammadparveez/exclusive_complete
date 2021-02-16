import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_details.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/shipping_method_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_customer_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/data/repository/auth_repo.dart';
import 'package:sixvalley_ui_kit/data/repository/profile_repo.dart';
import 'package:sixvalley_ui_kit/data/shipping_update_model.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class OrderRepo {
  final List<OrderModel> _orderList = [];

  Future<List<OrderModel>> fetchOrders(int userID,
      {int pageCount, String status}) async {
    print(
        "My Order URL ${AppConstants.WP_ORDER_URI}$userID${AppConstants.ORDER_BY_STATUS}$status${AppConstants.WP_ORDER_PAGE}$pageCount");
    final response = await get(
        "${AppConstants.WP_ORDER_URI}$userID${AppConstants.ORDER_BY_STATUS}$status${AppConstants.WP_ORDER_PAGE}$pageCount",
        //"${AppConstants.WP_ORDER_URI}$userID${AppConstants.WP_ORDER_PAGE}$pageCount",
        headers: {
          HttpHeaders.authorizationHeader: AppConstants.JWT_ADMIN_TOKEN
        });
    final List<OrderModel> orderList = [];
    print("Order are ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = await jsonDecode(response.body);
      print("Order Data ${data}");
      final items = data as List;
      for (dynamic i in items) {
        print("Order is Checking: $i");
        orderList.add(OrderModel.fromJson(i));
      }
    }
    return orderList;
  }

  List<OrderModel> getOrderList() {
    List<OrderModel> orderList = [
      /*  OrderModel(
          id: 100030,
          customerId: '1',
          paymentStatus: 'pending',
          orderAmount: '10000',
          shippingAddress: 'Dhaka, Bangladesh',
          discountAmount: '1000',
          discountType: 'amount',
          createdAt: '12-12-20',
          orderStatus: 'pending'),
      OrderModel(
          id: 100031,
          customerId: '1',
          paymentStatus: 'pending',
          orderAmount: '20000',
          shippingAddress: 'Dhaka, Bangladesh',
          discountAmount: '2000',
          discountType: 'amount',
          createdAt: '12-12-20',
          orderStatus: 'delivered'),*/
    ];
    return _orderList;
  }

  List<OrderDetailsModel> getOrderDetails() {
    List<OrderDetailsModel> orderDetailsList = [
      OrderDetailsModel(
          id: 1,
          orderId: '1',
          productId: '1',
          sellerId: '1',
          productDetails: Product(
              1,
              'admin',
              '1',
              'Lamborghini',
              '',
              [],
              '',
              '',
              '1',
              '',
              ['assets/images/white_car.png', 'assets/images/blue_car.png'],
              'assets/images/blue_car.png',
              '',
              '',
              '',
              '',
              [ProductColors(name: 'Black', code: '#000000')],
              '',
              [],
              [],
              [],
              '',
              '500',
              '450',
              '5',
              'percent',
              '10',
              'percent',
              '10',
              'Tripod Projection Screen. This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty',
              '',
              '',
              '',
              '',
              '',
              '',
              [Rating(average: '3.7')]),
          qty: '1',
          price: '10000',
          discount: '1000',
          deliveryStatus: 'pending',
          paymentStatus: 'pending',
          shippingMethodId: '1',
          createdAt: '12-12-20'),
      OrderDetailsModel(
          id: 1,
          orderId: '1',
          productId: '1',
          sellerId: '1',
          productDetails: Product(
              1,
              'admin',
              '1',
              'Lamborghini',
              '',
              [],
              '',
              '',
              '1',
              '',
              ['assets/images/white_car.png', 'assets/images/blue_car.png'],
              'assets/images/blue_car.png',
              '',
              '',
              '',
              '',
              [ProductColors(name: 'Black', code: '#000000')],
              '',
              [],
              [],
              [],
              '',
              '500',
              '450',
              '5',
              'percent',
              '10',
              'percent',
              '10',
              'Tripod Projection Screen. This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty',
              '',
              '',
              '',
              '',
              '',
              '',
              [Rating(average: '3.7')]),
          qty: '1',
          price: '10000',
          discount: '1000',
          deliveryStatus: 'pending',
          paymentStatus: 'pending',
          shippingMethodId: '1',
          createdAt: '12-12-20'),
    ];
    return orderDetailsList;
  }

  List<ShippingMethodModel> getShippingList() {
    List<ShippingMethodModel> shippingMethodList = [
      ShippingMethodModel(
          id: 1, title: 'Currier', cost: '20', duration: '2-3 days'),
      ShippingMethodModel(
          id: 2, title: 'Company Vehicle', cost: '10', duration: '8-10 days'),
    ];
    return shippingMethodList;
  }

  Future<List<OrderModel>> getOrdersByUserID(
      {int pageCount = 1, String status}) async {
    final perfs = GetIt.instance.get<SharedPreferences>();

    final userID = perfs.get(AppConstants.WP_USER_ID);
    print("Order User ID ${userID}");
    final List<OrderModel> orders =
        await fetchOrders(userID, pageCount: pageCount, status: status);
    print("Orders are ${orders.length}");

    /*  if (response.statusCode == 200 || response.statusCode == 201) {
      final data = await jsonDecode(response.body);
      final items = data as List;
      for (dynamic i in items) _orderList.add(OrderModel.fromJson(i));
    }*/
    print("${_orderList} List OF ORders");
    return orders;
  }

  addOrder(OrderModel orderModel) {
    _orderList.add(orderModel);
  }

  Future<OrderModel> makeOrder({
    @required int userID,
    @required WordPressProductModel wordPressProductModel,
    @required BillingAddressModel billingAddressModel,
    @required paymentMethod,
    String countryModel,
    String paymentType,
    selectedCountryCode,
    String paymentTitle,
    List<CartModel> cartModel,
    ShippingUpdateModel shippingUpdateModel,
  }) async {
    print("List Of Order ${cartModel.length}");
    String productsMapWithId = "[";
    double totalAmount = 0;
    for (int i = 0; i < cartModel.length; i++) {
      totalAmount += cartModel[i].price;
      if (i < cartModel.length - 1)
        productsMapWithId +=
            """{"product_id":${cartModel[i].id}, "quantity":${cartModel[i].quantity}},""";
      else
        productsMapWithId +=
            """{"product_id":${cartModel[i].id}, "quantity":${cartModel[i].quantity}}""";
    }
    productsMapWithId += "]";
    print(
        "My Custom Json and ID IS ${cartModel.first.id} ${productsMapWithId}");
    final authRepo = GetIt.instance.get<AuthRepo>();
    final detailsProvider = GetIt.instance.get<ProductDetailsProvider>();
    final email = authRepo.getUserEmail();
    final profileRepo = GetIt.instance.get<ProfileRepo>();
    final addreses = profileRepo.getAllAddress();
    final BillingAddressModel address = addreses.last;
    final fullName = authRepo.getUserDisplayName().split(' ');
    String firstName = "", lastName = "";
    if (fullName.length > 2) {
      firstName = fullName[0];
      lastName = lastName[1];
    } else {
      firstName = fullName[0];
    }
    final rawData = """ {
  "customer_id": $userID,
  "payment_method": "$paymentType",
  "payment_method_title": "$paymentTitle",

  "billing": {
    "first_name": "$firstName",
    "last_name": "$lastName",
    "address_1": "${billingAddressModel.address_1}",
    "address_2": "",
    "city": "${billingAddressModel.city}",
    "state": "${billingAddressModel.state}",
    "postcode": "${billingAddressModel.postcode}",
    "country": "${selectedCountryCode}",
    "email": "$email",
    "phone": "${billingAddressModel.phone}"
  },
  "shipping": {
    "first_name": "$firstName",
    "last_name": "$lastName",
    "address_1": "${billingAddressModel.address_1}",
    "address_2": "",
    "city": "${billingAddressModel.city}",
    "state": "${billingAddressModel.state}",
    "postcode": "${billingAddressModel.postcode}",
    "country": "${selectedCountryCode}"
  },
  "line_items": $productsMapWithId,
  "shipping_lines": [
    {
    "method_id": "${shippingUpdateModel.shippingRates.first.shippingRates.first.methodId}",
    "method_title": "${shippingUpdateModel.shippingRates.first.shippingRates.first.name}",
    "total": "${shippingUpdateModel.shippingRates.first.shippingRates.first.price}"
    }
    ]
}""";
    /**/
    print(
        "Shipping Cost ${shippingUpdateModel.shippingRates.first.shippingRates.first.price} and ID ${shippingUpdateModel.shippingRates.first.shippingRates.first.methodId}");
    print("Order JSON ${rawData}");
    /* final rawData = """ {
  "customer_id": $userID,
  "payment_method": $paymentType,
  "billing": {
     "first_name": "$firstName",
    "last_name": "$lastName",
    "address_1": "${billingAddressModel.address_1}",
    "address_2": "",
    "city": "${billingAddressModel.city}",
    "state": "${billingAddressModel.state}",
    "postcode": "${billingAddressModel.postcode}",
    "country": "${billingAddressModel.country}",
    "email": "$email",
    "phone": "${billingAddressModel.phone}"
  },
  "shipping": {
   "first_name": "$firstName",
    "last_name": "$lastName",
    "address_1": "${billingAddressModel.address_1}",
    "address_2": "",
    "city": "${billingAddressModel.city}",
    "state": "${billingAddressModel.state}",
    "postcode": "${billingAddressModel.postcode}",
    "country": "${billingAddressModel.country}"
  },
  "line_items": $productsMapWithId,
  "shipping_lines": [
    {
      "method_id": "flat_rate",
      "method_title": "Flat Rate",
      "total": "${totalAmount}"
    }
  ]
}""";*/

    final response = await post(AppConstants.ADD_ORDER_URI,
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: AppConstants.JWT_ADMIN_TOKEN,
              //"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGVzdC5leGNsdXNpdmVpbm4uY29tIiwiaWF0IjoxNjEyOTU5Mjg1LCJuYmYiOjE2MTI5NTkyODUsImV4cCI6MTYxMzU2NDA4NSwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiMSJ9fX0.BSscGb9rzg-MIm6qIdHoSx4TJ8fhfo9MibGJ2h05Cng", //AppConstants.JWT_ADMIN_TOKEN
            },
            body: rawData)
        .timeout(Duration(seconds: 20));
    print(
        "Finding and checking Order ${response.body} and Status: ${response.statusCode}");
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = await jsonDecode(response.body);
      print("Is my order done ${data}");
      (data as Map).forEach((key, value) {
        print("$key and $value\n");
      });
      return OrderModel.fromJson(data);
    } else {
      print("Checking some errors with order");
      return null;
    }
    print("Raw Data ${rawData}");
    return null;
  }
}
