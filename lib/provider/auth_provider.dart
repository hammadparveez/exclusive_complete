import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sixvalley_ui_kit/data/model/body/login_model.dart';
import 'package:sixvalley_ui_kit/data/model/body/register_model.dart';
import 'package:sixvalley_ui_kit/data/model/body/user_model.dart';
import 'package:sixvalley_ui_kit/data/repository/auth_repo.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/customer_provider.dart';
import 'package:uuid/uuid.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  UserModel _userModel;
  RegisterModel _registerModel;
  UserModel get userModel => _userModel;
  bool isInvalidAuth = false;
  AuthProvider({@required this.authRepo});
  bool _isRemember = false, _isUserLoggedIn = false;
  bool _isFromSomeWhere = false;

  RegisterModel get registerModel => _registerModel;

  set registerModel(RegisterModel value) {
    _registerModel = value;
  }

  get isUserLoggedIn => _isUserLoggedIn;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  bool get isRemember => _isRemember;

  void updateRemember(bool value) {
    _isRemember = value;
    notifyListeners();
  }

  Future registration(RegisterModel register) async {
    authRepo.saveUserToken('token');
  }

  Future<UserModel> login(LoginModel loginBody) async {
    final token = Uuid().v4();
    try {
      _userModel = await authRepo.login(loginBody);
      if (_userModel != null) {
        print("Login Model ${loginBody.email} and ${_userModel}");
        final customer = await GetIt.instance
            .get<CustomerProvider>()
            .fetchCustomerInfo(_userModel.id);
        if (customer.billingAddressModel != null) {
          final userAddress = customer.billingAddressModel;
          print("User Address is ${userAddress.address_1}");
          if (_userModel != null) {
            print("--------userID ${_userModel.id}");
            await authRepo.saveUserToken(token);
            await authRepo.saveUserEmail(userModel.user_email);
            await authRepo.saveDisplayName(_userModel.display_name);
            await authRepo.saveUserId(_userModel.id);
            print("Check user ID ${_userModel.id} and ${getUserID()}");
            isInvalidAuth = isLoggedIn();
          }
        }
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Something wrong");
    }
    print("Customer Address");

    return _userModel;
    //notifyListeners();
  }

  Future<bool> register(RegisterModel registerModel) async {
    _userModel = await authRepo.register(registerModel);
    print("Check if user is register ${_userModel}");
    //await authRepo.saveUserToken(token);
    //await authRepo.saveUserEmail(registerModel.email);
    //await authRepo.saveDisplayName(_userModel.display_name);
    if (_userModel != null) {
      final token = Uuid().v4();
      await authRepo.saveDisplayName(_userModel.display_name);
      await authRepo.saveUserEmail(_userModel.user_email);
      await authRepo.saveUserToken(token);
      await authRepo.saveUserId(_userModel.id);
      return isLoggedIn();
    }
    return false;

    //notifyListeners();
  }

  // for user Section
  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool isLoggedIn() {
    _isUserLoggedIn = authRepo.isLoggedIn();
    isInvalidAuth = _isUserLoggedIn;
    notifyListeners();
    return _isUserLoggedIn;
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  Future<bool> signOut() async {
    final userLoggedIn = await authRepo.signOut();
    GetIt.instance.get<CartProvider>().cartList.clear();
    isLoggedIn();
    //notifyListeners();
    return userLoggedIn;
  }

  // for  Remember Email
  void saveUserEmail(String email, String password) {
    authRepo.saveUserEmailAndPassword(email, password);
  }

  void saveDisplayName(String displayName) {
    authRepo.saveDisplayName(displayName);
  }

  String getUserEmail() {
    return authRepo.getUserEmail() ?? "guest@exclusiveinn.com";
  }

  String getUserDisplayName() {
    return authRepo.getUserDisplayName() ?? "guest@exclusiveinn.com";
  }

  int getUserID() {
    return authRepo.getUserID();
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo.clearUserEmailAndPassword();
  }

  String getUserPassword() {
    return authRepo.getUserPassword() ?? "";
  }

  bool get isFromSomeWhere => _isFromSomeWhere;

  set isFromSomeWhere(bool value) {
    _isFromSomeWhere = value;
    notifyListeners();
  }
}
