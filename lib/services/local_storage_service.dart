import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/index.dart';

class LocalStorageService {
  static const String _userKey = 'user';
  static const String _cartKey = 'cart';
  static const String _isLoggedInKey = 'isLoggedIn';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  // User & Authentication
  Future<bool> saveUser(User user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      return await _prefs.setString(_userKey, userJson);
    } catch (e) {
      throw Exception('فشل حفظ بيانات المستخدم: $e');
    }
  }

  Future<User?> getUser() async {
    try {
      final userJson = _prefs.getString(_userKey);
      if (userJson != null) {
        final decoded = jsonDecode(userJson);
        return User.fromJson(decoded);
      }
      return null;
    } catch (e) {
      throw Exception('فشل استرجاع بيانات المستخدم: $e');
    }
  }

  Future<bool> setLoginStatus(bool isLoggedIn) async {
    return await _prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<bool> clearUser() async {
    try {
      return await _prefs.remove(_userKey);
    } catch (e) {
      throw Exception('فشل حذف بيانات المستخدم: $e');
    }
  }

  // Cart Management
  Future<bool> saveCart(List<CartItem> cart) async {
    try {
      final cartJson = jsonEncode(
        cart.map((item) => {
          'product': item.product.toJson(),
          'quantity': item.quantity,
        }).toList(),
      );
      return await _prefs.setString(_cartKey, cartJson);
    } catch (e) {
      throw Exception('فشل حفظ السلة: $e');
    }
  }

  Future<List<CartItem>> getCart() async {
    try {
      final cartJson = _prefs.getString(_cartKey);
      if (cartJson != null) {
        final List<dynamic> decoded = jsonDecode(cartJson);
        return decoded.map((item) {
          return CartItem(
            product: Product.fromJson(item['product']),
            quantity: item['quantity'],
          );
        }).toList();
      }
      return [];
    } catch (e) {
      throw Exception('فشل استرجاع السلة: $e');
    }
  }

  Future<bool> clearCart() async {
    try {
      return await _prefs.remove(_cartKey);
    } catch (e) {
      throw Exception('فشل حذف السلة: $e');
    }
  }
}
