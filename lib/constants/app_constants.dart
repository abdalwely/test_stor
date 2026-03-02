/// Application Constants
class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'https://fakestoreapi.com';
  static const String productsEndpoint = '/products';

  // Authentication
  static const String correctOTP = '0000';
  static const String defaultCountry = '🇸🇦 السعودية';

  // Local Storage Keys
  static const String userKey = 'user';
  static const String cartKey = 'cart';
  static const String isLoggedInKey = 'isLoggedIn';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration snackBarDuration = Duration(milliseconds: 1500);

  // Country Codes
  static const List<String> supportedCountries = [
    '🇸🇦 السعودية',
    '🇦🇪 الإمارات',
    '🇪🇬 مصر',
    '🇰🇼 الكويت',
    '🇶🇦 قطر',
    '🇧🇭 البحرين',
    '🇴🇲 عمان',
  ];

  // Error Messages
  static const String errorLoadingProducts = 'فشل تحميل المنتجات';
  static const String errorNetworkConnection = 'خطأ في الاتصال';
  static const String errorUnexpected = 'خطأ غير متوقع';
  static const String errorLoadingProductDetails = 'فشل تحميل تفاصيل المنتج';
  static const String errorSavingUserData = 'فشل حفظ بيانات المستخدم';
  static const String errorLoadingUserData = 'فشل استرجاع بيانات المستخدم';
  static const String errorDeletingUserData = 'فشل حذف بيانات المستخدم';
  static const String errorSavingCart = 'فشل حفظ السلة';
  static const String errorLoadingCart = 'فشل استرجاع السلة';
  static const String errorDeletingCart = 'فشل حذف السلة';
  static const String errorUpdatingQuantity = 'فشل تحديث كمية المنتج';
  static const String errorAddingToCart = 'فشل إضافة المنتج للسلة';
  static const String errorRemovingFromCart = 'فشل حذف المنتج من السلة';
  static const String errorLogin = 'فشل تسجيل الدخول';
  static const String errorLogout = 'فشل تسجيل الخروج';

  // Validation Messages
  static const String emptyEmailError = 'يرجى إدخال البريد الإلكتروني';
  static const String emptyPasswordError = 'يرجى إدخال كلمة المرور';
  static const String emptyPhoneError = 'يرجى إدخال رقم جوالك';
  static const String emptyOTPError = 'يرجى إدخال الرمز الكامل';
  static const String invalidOTP = 'الرمز غير صحيح. الرمز الصحيح: 0000';

  // Success Messages
  static const String loginSuccess = 'تم تسجيل الدخول بنجاح';
  static const String logoutSuccess = 'تم تسجيل الخروج بنجاح';
  static const String addedToCart = 'تمت إضافة المنتج للسلة';
}
