import 'package:flutter/material.dart';
import '../models/index.dart';
import '../services/index.dart';

class AuthProvider extends ChangeNotifier {
  final LocalStorageService _storageService;

  // ✅ استقبل الخدمة جاهزة
  AuthProvider(this._storageService);

  User? _user;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Initialize auth state
  Future<void> initializeAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      _isLoggedIn = await _storageService.getLoginStatus();
      if (_isLoggedIn) {
        _user = await _storageService.getUser();
      }
    } catch (e) {
      _error = e.toString();
      _isLoggedIn = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Login with email (Mock)
  Future<bool> loginWithEmail(String email, String password, LocalStorageService storage) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        isLoggedIn: true,
      );

      await _storageService.saveUser(user);
      await _storageService.setLoginStatus(true);

      _user = user;
      _isLoggedIn = true;

      return true;
    } catch (e) {
      _error = 'فشل تسجيل الدخول: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Login with phone (Mock)
  Future<bool> loginWithPhone(
      String phoneNumber,
      String country, LocalStorageService storage,
      ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        phoneNumber: phoneNumber,
        country: country,
        isLoggedIn: true,
      );

      await _storageService.saveUser(user);
      await _storageService.setLoginStatus(true);

      _user = user;
      _isLoggedIn = true;

      return true;
    } catch (e) {
      _error = 'فشل تسجيل الدخول: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _storageService.clearUser();
      await _storageService.setLoginStatus(false);

      _user = null;
      _isLoggedIn = false;

      notifyListeners();
    } catch (e) {
      _error = 'فشل تسجيل الخروج: $e';
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}