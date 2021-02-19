import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/data/repository/cart_repo.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo cartRepo;
  CartProvider({@required this.cartRepo});

  List<CartModel> _cartList = [];
  List<bool> _isSelectedList = [];
  double _amount = 0.0;
  bool _isSelectAll = true;
  bool _isLoading = true;
  bool _isDeleting = true;
  int _totalItemsInCart = 0;
  bool _isCartAdded = true;

  bool get isCartAdded => _isCartAdded;

  set isCartAdded(bool value) {
    _isCartAdded = value;
    notifyListeners();
  }

  int get totalItemsInCart => _totalItemsInCart;

  bool get isDeleting => _isDeleting;

  bool get isSelectAll => _isSelectAll;

  set isSelectAll(bool value) {
    _isSelectAll = value;
  }

  set isDeleting(value) {
    _isDeleting = value;
    notifyListeners();
  }

  List<CartModel> get cartList => _cartList;
  List<bool> get isSelectedList => _isSelectedList;
  double get amount => _amount;
  bool get isAllSelect => _isSelectAll;

  Future<void> getCartData() async {
    try {
      _cartList.clear();
      print("Getting Cart List");
      _isSelectedList.clear();
      _isSelectAll = true;

      final c = await cartRepo.getCartList();
      _totalItemsInCart = c.length;
      c.forEach((element) {
        print("Cart Item Keys: ${element.itemKey}");
      });
      c.forEach((element) {
        _cartList.add(element);
        _isSelectedList.add(true);
      });
      _amount = cartRepo.getTotal();
    } catch (error) {
      print("Something wrong cart was not fetched ${error}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetCart() {
    _cartList.clear();
    notifyListeners();
  }

  void clearTotalItemsInCart() {
    _totalItemsInCart = 0;
    notifyListeners();
  }

  void displayCartList() async {
    final cartmodels = await cartRepo.getCartList();
    print("My Cart models are ${cartmodels}");
    _cartList = [];
    //notifyListeners();
  }

  void setQuantity(bool isIncrement, int index) {
    if (isIncrement) {
      _cartList[index].quantity = _cartList[index].quantity + 1;
      _isSelectedList[index]
          ? _amount = _amount + _cartList[index].price
          : _amount = _amount;
    } else {
      _cartList[index].quantity = _cartList[index].quantity - 1;
      _isSelectedList[index]
          ? _amount = _amount - _cartList[index].price
          : _amount = _amount;
    }
    cartRepo.addToCartList(_cartList);

    notifyListeners();
  }

  void toggleSelected(int index) {
    _isSelectedList[index] = !_isSelectedList[index];

    _amount = 0.0;
    for (int i = 0; i < _isSelectedList.length; i++) {
      if (_isSelectedList[i]) {
        _amount =
            _amount + (_cartList[i].price); // * _cartList[index].quantity);
      }
    }

    _isSelectedList
        .forEach((isSelect) => isSelect ? null : _isSelectAll = false);

    notifyListeners();
  }

  void toggleAllSelect() {
    _isSelectAll = !_isSelectAll;
    _amount = 0;
    if (_isSelectAll) {
      _amount = 0.0;
      for (int i = 0; i < _isSelectedList.length; i++) {
        _isSelectedList[i] = true;
        _amount = _amount + (_cartList[i].price); // * _cartList[i].quantity);
      }
    } else {
      _amount = 0.0;
      for (int i = 0; i < _isSelectedList.length; i++) {
        _isSelectedList[i] = false;
      }
    }

    notifyListeners();
  }

  Future<void> initTotalCartCount() async {
    final totalCounts = await cartRepo.getTotalCartCount();
    _totalItemsInCart = totalCounts;
    print("Total Counts Are ${_totalItemsInCart} and ${totalCounts}");
    notifyListeners();
  }

  Future<void> addToCart(CartModel cartModel) async {
    try {
      final cart = await cartRepo.addToCart(cartModel);
      _totalItemsInCart = await cartRepo.getTotalCartCount();
      _amount = cartRepo.getTotal();
      _cartList.add(cart);
      print(
          "_________________CartList Length ${_cartList.length}+++++++++++++++");
      _isSelectedList.add(true);
      //cartRepo.addToCartList(_cartList);
      _amount =
          _amount + (cartModel.price /*cartModel.price * cartModel.quantity*/);
      print("Cart has been added to the website");
      print("Cart is not null $cart");
      if (cart != null) {
        print("Cart is not null $cart");
        _isCartAdded = true;
      } else {
        _isCartAdded = false;
        print("Cart is Null");
      }
    } catch (error) {
      _isCartAdded = false;
      print("Something went wrong, ${_isCartAdded} when adding cart ${error}");
    }

    notifyListeners();
  }

  Future<void> removeFromCart(int index, {String itemRemovingKey}) async {
    print("Item going to be removed");
    final cart =
        _cartList.firstWhere((element) => element.itemKey == itemRemovingKey);
    final removingIndex =
        _cartList.indexWhere((element) => element.itemKey == itemRemovingKey);
    final isRemoved = await cartRepo.removeCart(itemRemovingKey);
    print(
        "Item Removed and ITem Index ${removingIndex} and IsRemoved $isRemoved");
    if (_isSelectedList[removingIndex]) {
      _amount = _amount - (_cartList[removingIndex].price);
    }
    if (isRemoved) {
      _isDeleting = false;
      print("Key of an item ${cart.itemKey}");
      _cartList.removeAt(removingIndex);
      _isSelectedList.removeAt(removingIndex);
      //cartRepo.addToCartList(_cartList);
    }
    notifyListeners();
  }

  bool isAddedInCart(int id) {
    List<int> idList = [];
    //_cartList.forEach((cartModel) => idList.add(cartModel.id));
    return idList.contains(id);
  }

  void removeCheckoutProduct(List<CartModel> carts) {
    carts.forEach((cart) {
      _amount = _amount - (cart.price * cart.quantity);
      int index = _cartList.indexOf(cart);
      _cartList.removeAt(index);
      _isSelectedList.removeAt(index);
    });
    cartRepo.addToCartList(_cartList);
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
