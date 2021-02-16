import 'package:flutter/cupertino.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_customer_model.dart';
import 'package:sixvalley_ui_kit/data/repository/billing_address_repo.dart';

class BillingAddressProvider extends ChangeNotifier {
  final BillingAddressRepo _billingAddressRepo = BillingAddressRepo();
  BillingAddressModel _billingAddressModel;

  BillingAddressModel get billingAddressModel => _billingAddressModel;
  updateBillingAddress({
    String firstName,
    String lastName,
    String addr1,
    String addr2,
    String city,
    String zipCode,
    String country,
    String state,
    String phoneNo,
  }) async {
    _billingAddressModel = await _billingAddressRepo.updateBillingAddress(
      firstName: firstName,
      lastName: lastName,
      addr1: addr1,
      addr2: addr2,
      city: city,
      zipCode: zipCode,
      country: country,
      state: state,
      phoneNo: phoneNo,
    );
    notifyListeners();
    //return _billingAddressModel;
  }
}
