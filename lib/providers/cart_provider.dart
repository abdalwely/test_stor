import 'package:flutter/material.dart';
import '../models/index.dart';
import '../services/index.dart';

class CartProvider extends ChangeNotifier {
  final LocalStorageService _storageService;

  // ✅ استقبل الخدمة جاهزة
  CartProvider(this._storageService);

  List<CartItem> _items = [];
  String? _error;

  List<CartItem> get items => _items;
  String? get error => _error;

  int get itemCount => _items.length;

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// Initialize cart from local storage
  Future<void> initializeCart() async {
    try {
      _items = await _storageService.getCart();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  /// Add product to cart
  Future<void> addToCart(Product product) async {
    try {
      final existingIndex =
      _items.indexWhere((item) => item.product.id == product.id);

      if (existingIndex >= 0) {
        final existingItem = _items[existingIndex];
        _items[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + 1,
        );
      } else {
        _items.add(CartItem(product: product, quantity: 1));
      }

      await _storageService.saveCart(_items);
      notifyListeners();
    } catch (e) {
      _error = 'فشل إضافة المنتج للسلة: $e';
      notifyListeners();
    }
  }

  /// Remove product from cart
  Future<void> removeFromCart(int productId) async {
    try {
      _items.removeWhere((item) => item.product.id == productId);
      await _storageService.saveCart(_items);
      notifyListeners();
    } catch (e) {
      _error = 'فشل حذف المنتج من السلة: $e';
      notifyListeners();
    }
  }

  /// Update product quantity in cart
  Future<void> updateQuantity(int productId, int quantity) async {
    try {
      final index =
      _items.indexWhere((item) => item.product.id == productId);

      if (index >= 0) {
        if (quantity <= 0) {
          await removeFromCart(productId);
        } else {
          _items[index] =
              _items[index].copyWith(quantity: quantity);
          await _storageService.saveCart(_items);
          notifyListeners();
        }
      }
    } catch (e) {
      _error = 'فشل تحديث كمية المنتج: $e';
      notifyListeners();
    }
  }

  /// Clear entire cart
  Future<void> clearCart() async {
    try {
      _items.clear();
      await _storageService.clearCart();
      notifyListeners();
    } catch (e) {
      _error = 'فشل تفريغ السلة: $e';
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}