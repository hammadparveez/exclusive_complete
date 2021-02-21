import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/payment_gateway_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/address_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/user_info_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_customer_model.dart';
import 'package:sixvalley_ui_kit/data/repository/billing_address_repo.dart';
import 'package:sixvalley_ui_kit/data/repository/profile_repo.dart';
import 'package:sixvalley_ui_kit/data/shipping_update_model.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo profileRepo;
  final BillingAddressRepo billingAddressRepo;
  Map<String, dynamic> countryModel = {};
  List<CountryMethodModel> countryMethodModel = [];
  String _countrySelectedCode;
  String _countryName;
  bool _isAddressLoading = false;
  ShippingUpdateModel shippingUpdateModel;
  bool get isAddressLoading => _isAddressLoading;

  String get countryName => _countryName;
  int _selectedIndexValue = 0;
  int _groupRadioValue = 0;

  int get groupRadioValue => _groupRadioValue;

  set groupRadioValue(int value) {
    _groupRadioValue = value;
    notifyListeners();
  }

  int get selectedIndexValue => _selectedIndexValue;

  set selectedIndexValue(int value) {
    _selectedIndexValue = value;
    notifyListeners();
  }

  String get countrySelectedCode => _countrySelectedCode;

  set countrySelectedCode(String value) {
    _countrySelectedCode = value;
    _countryName = countryModel[value];
    print(
        "On Country change Value is ${_countrySelectedCode} and ${_countryName = countryModel[value]}");
    notifyListeners();
  }

  ProfileProvider({@required this.profileRepo, this.billingAddressRepo});

  List<String> _addressTypeList = [];
  List<String> get addressTypeList => _addressTypeList;

  String _addressType = '';
  String get addressType => _addressType;

  UserInfoModel _userInfoModel;
  UserInfoModel get userInfoModel => _userInfoModel;

  bool _isAvailableProfile = false;
  bool get isAvailableProfile => _isAvailableProfile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _hasAddressAdded = false;
  bool _isShippingLoaded = true;
  bool _isAddressExists = false;

  bool get isAddressExists => _isAddressExists;

  set isAddressExists(bool value) {
    _isAddressExists = value;
  }

  List<PaymentGateway> _paymentGatewaysList = [];
  String _paymentGatewaySelectedValue;
  String _paymentGatewayTitle;

  String get paymentGatewayTitle => _paymentGatewayTitle;

  set paymentGatewayTitle(value) {
    _paymentGatewayTitle = value;
  }

  String get paymentGatewaySelectedValue => _paymentGatewaySelectedValue;

  set paymentGatewaySelectedValue(String value) {
    _paymentGatewaySelectedValue = value;
    notifyListeners();
  }

  List<PaymentGateway> get paymentGatewaysList => _paymentGatewaysList;

  bool get isShippingLoaded => _isShippingLoaded;

  set isShippingLoaded(bool value) {
    _isShippingLoaded = value;
    notifyListeners();
  }

  bool get hasAddressAdded =>
      _hasAddressAdded; //List<AddressModel> _addressList;
  //List<AddressModel> get addressList => _addressList;

  List<BillingAddressModel> _addressList = [];
  List<BillingAddressModel> get addressList => _addressList;

  bool _hasData;
  bool get hasData => _hasData;

  bool _isHomeAddress = true;
  bool get isHomeAddress => _isHomeAddress;
  bool _isAddingAddressLoader = false;

  bool get isAddingAddressLoader => _isAddingAddressLoader;

  set isAddingAddressLoader(bool value) {
    _isAddingAddressLoader = value;
    notifyListeners();
  }

  void updateAddressCondition(bool value) {
    _isHomeAddress = value;
    notifyListeners();
  }

  bool _checkHomeAddress = false;
  bool get checkHomeAddress => _checkHomeAddress;

  bool _checkOfficeAddress = false;
  bool get checkOfficeAddress => _checkOfficeAddress;

  void setHomeAddress() {
    _checkHomeAddress = true;
    _checkOfficeAddress = false;
    notifyListeners();
  }

  void assignEmptyAddressList() {
    _addressList = [];
    notifyListeners();
  }

  void nullifyAddressList() {
    _addressList = null;
    notifyListeners();
  }

  void setOfficeAddress() {
    _checkHomeAddress = false;
    _checkOfficeAddress = true;
    notifyListeners();
  }

  updateCountryCode(String value) {
    _addressType = value;
    notifyListeners();
  }

  void initAddressList() async {
    _addressList = [];
    print("Address List is Empty");
    profileRepo.getAllAddress().forEach((address) {
      print("IS Address Empty $address");
      return _addressList.add(address);
    });
    notifyListeners();
  }

  void removeAddressById(int id, int index) async {
    _isLoading = true;
    notifyListeners();
    _addressList.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }

  void getUserInfo() async {
    _userInfoModel = profileRepo.getUserInfo();
    _isAvailableProfile = true;
    notifyListeners();
  }

  setUserAddressById(int userId) {}

  void clearAddressList() {
    if (_addressList != null) _addressList.clear();
    notifyListeners();
  }

  Future<void> updateShipping({String countryCode}) async {
    shippingUpdateModel =
        await profileRepo.updateShipping(countryCode: countryCode);
    _isShippingLoaded = false;
    notifyListeners();
  }

  void initAddressTypeList() async {
    if (_addressTypeList.length == 0) {
      _addressTypeList.clear();
      _addressTypeList.addAll(profileRepo.getAddressTypeList());
      _addressType = profileRepo.getAddressTypeList()[0];
      notifyListeners();
    }
  }

  fetchCountries() async {
    await billingAddressRepo.fetchCountries();
  }

  Future<void> fetchRegion() async {
    try {
      countryModel = await billingAddressRepo.getRegions();
    } catch (e) {
      print("Region Error ${e}");
      countryModel = null;
    }
    notifyListeners();
  }

  fetchRegionMethods(int countryId) async {
    countryMethodModel = await billingAddressRepo.getRegionMethod(countryId);
    notifyListeners();
  }

  Future addAddress(
      [AddressModel addressModel,
      BillingAddressModel billingAddressModel]) async {
    print("My bill and address added");

    final address = await billingAddressRepo.updateBillingAddress(
        firstName: "",
        lastName: "",
        addr1: billingAddressModel.address_1,
        addr2: billingAddressModel.address_2,
        city: billingAddressModel.city,
        zipCode: billingAddressModel.postcode,
        country: billingAddressModel.country,
        state: billingAddressModel.state,
        phoneNo: billingAddressModel.phone);
    print("AAAAAddr ${address}");
    if (address != null) {
      _addressList.add(billingAddressModel);
      _isAddingAddressLoader = false;
      _hasAddressAdded = true;
    } else {
      _isAddingAddressLoader = false;
      _hasAddressAdded = false;
    }

    notifyListeners();
  }

  Future updateUserInfo(UserInfoModel updateUserModel) async {
    _userInfoModel = updateUserModel;
    notifyListeners();
  }

  // save office and home address
  void saveHomeAddress(String homeAddress) {
    profileRepo.saveHomeAddress(homeAddress).then((_) {
      notifyListeners();
    });
  }

  void saveOfficeAddress(String officeAddress) {
    profileRepo.saveOfficeAddress(officeAddress).then((_) {
      notifyListeners();
    });
  }

  set isAddressLoading(value) {
    _isAddressLoading = value;
    notifyListeners();
  }

  resetAddressList() {
    _addressList = [];
    notifyListeners();
  }

  Future<BillingAddressModel> getAddressOfUser() async {
    _addressList?.clear();

    if (addressList != null) {
      if (addressList.isEmpty) {
        final address = await profileRepo.fetchUserAddress();
        if (address != null &&
            address.address_1.isNotEmpty &&
            address.country.isNotEmpty) {
          try {
            countryModel = await billingAddressRepo.getRegions();
            _countrySelectedCode = countryModel.keys
                .firstWhere((key) => countryModel[key] == address.country);
            print("${_countrySelectedCode}");
          } finally {
            _addressList.add(address);
            _isAddressLoading = false;
            _isAddingAddressLoader = false;

            _isAddressExists = true;
          }
        } else {
          _isAddressExists = false;
          _isAddingAddressLoader = false;
        }

        print(
            "Address has been added ${_addressList.length} and ${address} and ${_addressList}");
      }
    }

    notifyListeners();
    return null;
  }

  // for home Address Section
  String getHomeAddress() {
    return profileRepo.getHomeAddress();
  }

  Future<bool> clearHomeAddress() async {
    return await profileRepo.clearHomeAddress();
  }

  // for office Address Section
  String getOfficeAddress() {
    return profileRepo.getOfficeAddress();
  }

  Future<bool> clearOfficeAddress() async {
    return await profileRepo.clearOfficeAddress();
  }

  Future<void> fetchPaymentRegion() async {
    final paymentGatewaysList = await profileRepo.fetchPaymentGateways();
    _paymentGatewaysList = paymentGatewaysList;
    notifyListeners();
  }
}
