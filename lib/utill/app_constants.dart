import 'dart:io';

class AppConstants {
  //check uri network
  static const KEEP_ALIVE = "keep-alive";
  static const NETWORK_URI = "https://www.google.com/";
  //Hero widget tag
  static const TAG_NET_DIALOG = "internet_dialog";
  static const TAG_THUMBNAIL_IMG = "thumbnail_image_load";
  //Durations
  static const TIMED_OUT_20 = Duration(seconds: 60);

  static const String NO_PRODUCTS_FOUND =
      "No products were found matching your selection";
  static const String BASE_URL = 'http://dev.6amtech.com/api/';
  static const String USER_ID = 'userId';
  static const String NAME = 'name';
  static const String CATEGORIES_URI = 'v1/categories';
  static const String BRANDS_URI = 'v1/brands';
  static const String REGISTRATION_URI = 'v1/auth/register';
  static const String LOGIN_URI = 'v1/auth/login';
  static const String LATEST_PRODUCTS_URI =
      'v1/products/latest?limit=10&&offset=';
  static const String PRODUCT_DETAILS_URI = 'v1/products/details/';
  static const String PRODUCT_REVIEW_URI = 'v1/products/reviews/';
  static const String SEARCH_URI = 'v1/products/search?name=';
  static const String CONFIG_URI = 'v1/config';
  static const String ADD_WISH_LIST_URI =
      'v1/customer/wish-list/add?product_id=';
  static const String REMOVE_WISH_LIST_URI =
      'v1/customer/wish-list/remove?product_id=';
  static const String UPDATE_PROFILE_URI = 'v1/customer/update-profile';
  static const String CUSTOMER_URI = 'v1/customer/info';
  static const String ADDRESS_LIST_URI = 'v1/customer/address/list';
  static const String REMOVE_ADDRESS_URI = 'v1/customer/address?address_id=';
  static const String ADD_ADDRESS_URI = 'v1/customer/address/add';
  static const String WISH_LIST_GET_URI = 'v1/customer/wish-list';
  static const String SUPPORT_TICKET_URI = 'v1/customer/support-ticket/create';
  static const String MAIN_BANNER_URI = 'v1/banners?banner_type=main_banner';
  static const String FOOTER_BANNER_URI =
      'v1/banners?banner_type=footer_banner';
  static const String RELATED_PRODUCT_URI = 'v1/products/related-products/';
  static const String ORDER_URI = 'v1/customer/order/list';
  static const String ORDER_DETAILS_URI = 'v1/customer/order/details?order_id=';
  static const String ORDER_PLACE_URI = 'v1/customer/order/place';
  static const String SELLER_URI = 'v1/seller?seller_id=';
  static const String SELLER_PRODUCT_URI = 'v1/seller/';
  static const String TRACKING_URI = 'v1/order/track?order_id=';
  static const String FORGET_PASSWORD_URI = 'v1/auth/forgot-password';
  static const String SUPPORT_TICKET_GET_URI = 'v1/customer/support-ticket/get';
  static const String SUBMIT_REVIEW_URI = 'v1/products/reviews/submit';
  static const String FLASH_DEAL_URI = 'v1/flash-deals';
  static const String FLASH_DEAL_PRODUCT_URI = 'v1/flash-deals/products/';
  static const String COUNTER_URI = 'v1/products/counter/';
  static const String SOCIAL_LINK_URI = 'v1/products/social-share-link/';
  static const String SHIPPING_URI = 'v1/products/shipping-methods';
  static const String COUPON_URI = 'v1/coupon/apply?code=';
  static const String INVALID_EMAIL = "invalid_email";

  // sharePreference
  static const String TOKEN = 'token';
  static const String USER_EMAIL = 'user_email';
  static const String USER_DISPLAY_NAME = 'user_display_name';
  static const String WP_USER_ID = 'user_id';
  static const String USER_PASSWORD = 'user_password';
  static const String HOME_ADDRESS = 'home_address';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String OFFICE_ADDRESS = 'office_address';
  static const String CART_LIST = 'cart_list';
  static const String CONFIG = 'config';
  static const String GUEST_MODE = 'guest_mode';
  static const String CURRENCY = 'currency';
  static const String PRODUCTS_DATA = 'all_products';
  static const String WISH_LIST_KEY = "add_wish_list";
  static const String JWT_TOKEN_KEY = "jwt_token_of_user";
  static const NO_IMAGE_URI =
      "https://icon-library.com/images/no-photo-available-icon/no-photo-available-icon-4.jpg";
  //Customer WordPress Constant
  static const WP_CUSTOMER_URI =
      "https://www.exclusiveinn.com/wc-api/v3/customers/";

  //SharedPerferences Products Key
  static const FEATURED_PRODUCTS = "featured products";

  //SharedPerferences Products Key
  static const PRODUCTS_BY_ID_KEY = "PRODUCTS_BY_ID";

  static const SEARCH_PRODUCTS_KEY = "search_products_key";
  static const UPDATE_SHIPPING_URI =
      "https://www.exclusiveinn.com/wp-json/wc/store/cart/update-shipping?country=";
  static const SEARCH_PRODUCTS_URI =
      "https://www.exclusiveinn.com/wc-api/v3/products/?filter[q]=";
  //"https://www.exclusiveinn.com/wp-json/wc/v1/products/?search=";
  // "https://www.exclusiveinn.com/wc-api/v3/products/?search=";
  static const SEARCH_PER_PAGE = "page=";
  static const RELATED_PRODUCTS_BY_ID_URI =
      "https://www.exclusiveinn.com/wp-json/wc/v3/products?include=";
  //pages counts
  static const PRODUCTS_BY_ID_URI =
      "https://www.exclusiveinn.com/wp-json/wc/v3/products/";
  //"https://www.exclusiveinn.com/wc-api/v3/products/";
  static const RELATED_PRODUCTS_BY_IDS = "https://www.exclusiveinn.com/wc-api/v3/products/";
  // "https://www.exclusiveinn.com/wp-json/wc/store/products/";
  static const CATEGORY_COUNT_URI =
      "https://www.exclusiveinn.com/wc-api/v3/products/count?filter[category]=";
  static const CATEGORY_COUNT = "categories_count";

  //OrderID
  static const CANCELLED = "cancelled";
  static const PENDING = "pending";
  static const COMPLETED = "completed";
  static const PROCESSING = "processing";
  static const ON_HOLD = "on-hold";
  static const REFUNDED = "refunded";

  static const PK = "pk";
  static const PAY_PAL = "paypal";
  static const COD = "cod";
  static const BACS = "bacs";
  //ShippingZoneKey
  static const REGION_KEY = "shipping_zone_key";
  //addto cart api
  static const CART_LIST_URI =
      "https://www.exclusiveinn.com/wp-json/wc/store/cart";
  static const REMOVE_CART_URI =
      "https://www.exclusiveinn.com/wp-json/wc/store/cart/remove-item?key=";
  static const ADD_TO_CART_URI =
      "https://www.exclusiveinn.com/wp-json/wc/store/cart/add-item?id=";
  static const ADD_TO_CART_URI1 = "&quantity=";
  static const COUNTRIES_API_URI = "https://www.exclusiveinn.com/country/";
  //ShippingZone
  static const REGION_URI =
      "https://exclusiveinn.com/wp-json/wc/v3/shipping/zones/";
  static const REGION_METHODS_URI = "/methods/";
  //WOO Commerce API Constant
  static const CUSTOMER_URI_WITH_ADDR =
      "https://www.exclusiveinn.com/wp-json/wc/v3/customers/";
  static const JSON_CONTENT_TYPE = "application/json";
  static const JWT_ADMIN_TOKEN =
  "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmV4Y2x1c2l2ZWlubi5jb20iLCJpYXQiOjE2MTM5ODQ0MDQsIm5iZiI6MTYxMzk4NDQwNCwiZXhwIjoxOTU5NTg0NDA0LCJkYXRhIjp7InVzZXIiOnsiaWQiOiIxIn19fQ.T7fRCh21gD0nDPEtqCN4WzBeeBZwiUk1jNBHBkMG-2w";
      //"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmV4Y2x1c2l2ZWlubi5jb20iLCJpYXQiOjE2MTMzNzUyNjAsIm5iZiI6MTYxMzM3NTI2MCwiZXhwIjoxNjEzOTgwMDYwLCJkYXRhIjp7InVzZXIiOnsiaWQiOiIxIn19fQ.JaqnOGg52AJwlhDxHfoiV3wZ7YWEYAkAxgrWYV9DvpQ";
  //"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGVzdC5leGNsdXNpdmVpbm4uY29tIiwiaWF0IjoxNjEyOTU5Mjg1LCJuYmYiOjE2MTI5NTkyODUsImV4cCI6MTYxMzU2NDA4NSwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiMSJ9fX0.BSscGb9rzg-MIm6qIdHoSx4TJ8fhfo9MibGJ2h05Cng";
  //"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGVzdC5leGNsdXNpdmVpbm4uY29tIiwiaWF0IjoxNjEyMzUxMzU2LCJuYmYiOjE2MTIzNTEzNTYsImV4cCI6MTYxMjk1NjE1NiwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiMSJ9fX0.z6PCr4LtSZL01TE96_uO8NExDRKbZlClVLqUPsI7gl4";
  static const JWT_TOKEN =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmV4Y2x1c2l2ZWlubi5jb20iLCJpYXQiOjE2MTIyNDYxMzksIm5iZiI6MTYxMjI0NjEzOSwiZXhwIjoxNjEyODUwOTM5LCJkYXRhIjp7InVzZXIiOnsiaWQiOiIyMzc2OSJ9fX0.pD--hKo3ZDwK2W9qCJigrJFMAraoC_oZo2OfORT8ff4";
  static const CONSUMER_KEY = "ck_cd8e9885f3a8869434a2c35094dc0e43699acfcd";
  static const CONSUMER_SECRET_KEY =
      "cs_117ffb213c60e7a36a4954d2e154dfce24a5a9d3";
  static const WP_NAV_KEY = "wordpress_navigation_key";
  static const WP_CATEGORY_KEY = "wordpress_category_key";
  //URI
  static const WP_NAVIGATION_URI =
      "https://www.exclusiveinn.com/wp-json/wp-api-menus/v2/menus/31";
  static const BASE_URI = "https://www.exclusiveinn.com/";
  static const ADD_TO_CART_URI2 =
      "https://www.exclusiveinn.com/wp-json/wc/store/cart/add-item?id=";
  static const ADD_TO_CART_QTY = "&quantity=";
  static const ADD_ORDER_URI =
      "https://www.exclusiveinn.com/wp-json/wc/v3/orders";
  static const WP_PRODUCT_URI =
      "https://www.exclusiveinn.com/wc-api/v3/products?filter[limit]=-1";
  static const WP_PRODUCTS_WITH_LIMIT =
      "https://www.exclusiveinn.com/wc-api/v3/products?filter[limit]=";
  static const WP_ALL_CATEGORIES =
      "https://www.exclusiveinn.com/wc-api/v3/products/categories/?filter[limit]=-1";
  static const WP_CATEGORY_URI =
      "https://www.exclusiveinn.com/wc-api/v3/products/categories";
  static const WP_LOGIN_URI =
      // "https://www.exclusiveinn.com/wp-json/custom-plugin/login";
      "https://www.exclusiveinn.com/wp-json/custom-plugin/login";
  static const WP_JWT_URI =
      "https://www.exclusiveinn.com/wp-json/jwt-auth/v1/token";
  static const WP_REGISTER_URI =
      "https://www.exclusiveinn.com/wp-json/wp/v2/users/";
  static const WP_FEATURE_PRODUCTS_URI =
      "https://www.exclusiveinn.com/wc-api/v3/products?filter[featured]=true";
  static const WP_PAYMENT_GATEWAYS_URI =
      "https://www.exclusiveinn.com/wp-json/wc/v3/payment_gateways/";
  //"https://exclsiveinn.com/wc-api/v3/products?filter[featured]=true";
  //"https://www.exclusiveinn.com/wc-api/v3/products?filtuer[featured]=true";
  //"https://exclusiveinn.com/wp-json/wc/v3/products?featured=true&per_page=12";
  //"https://exclusiveinn.com/wc-api/v3/products?featured=true";
  static const PRODUCT_CATEGORY_SLUG = "/product-category/";
  //static const ORDER_BY_STATUS_URI =  "https://www.exclusiveinn.com/wp-json/wc/v3/orders?customer=23769";
  static const ORDER_BY_STATUS = "&status=";
  static const WP_ORDER_URI =
      "https://www.exclusiveinn.com/wp-json/wc/v3/orders?customer=";
  static const WP_ORDER_PAGE = "&page=";
  static const BASIC_AUTH = "Basic Y2tfM2Y5MTcwMGZhMTQ4YTMxYmVjMWU1MzZlYTEwNWJlMGFlZWE2NjRhYzpjc183M2U0ODZkZDU1YjBhNDE1NDY3ZDcyZmY2MjgxYmRiMDNiNzVmNjBk";
  static const Map<String, String> WP_AUTH_HEADER = {
    HttpHeaders.authorizationHeader:
        //"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmV4Y2x1c2l2ZWlubi5jb20iLCJpYXQiOjE2MTIyNTI2NzMsIm5iZiI6MTYxMjI1MjY3MywiZXhwIjoxNjEyODU3NDczLCJkYXRhIjp7InVzZXIiOnsiaWQiOiIxIn19fQ.lVPW24IkvDNLIEiWpMN7X6EUOKcFmd-q86HTnFOUBfU",
        "Basic Y2tfM2Y5MTcwMGZhMTQ4YTMxYmVjMWU1MzZlYTEwNWJlMGFlZWE2NjRhYzpjc183M2U0ODZkZDU1YjBhNDE1NDY3ZDcyZmY2MjgxYmRiMDNiNzVmNjBk",
    HttpHeaders.connectionHeader: AppConstants.KEEP_ALIVE,
    //"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmV4Y2x1c2l2ZWlubi5jb20iLCJpYXQiOjE2MTIyNDYxMzksIm5iZiI6MTYxMjI0NjEzOSwiZXhwIjoxNjEyODUwOTM5LCJkYXRhIjp7InVzZXIiOnsiaWQiOiIyMzc2OSJ9fX0.pD--hKo3ZDwK2W9qCJigrJFMAraoC_oZo2OfORT8ff4, Basic Y2tfM2Y5MTcwMGZhMTQ4YTMxYmVjMWU1MzZlYTEwNWJlMGFlZWE2NjRhYzpjc183M2U0ODZkZDU1YjBhNDE1NDY3ZDcyZmY2MjgxYmRiMDNiNzVmNjBk"
  };
}
