import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'providers/index.dart';
import 'screens/index.dart';
import 'services/index.dart';
import 'theme/app_theme.dart';

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// Services
        Provider<LocalStorageService>(
          create: (_) => LocalStorageService(prefs),
        ),
        Provider<ApiService>(
          create: (_) => ApiService(),
        ),

        /// Providers
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) =>
              CartProvider(context.read<LocalStorageService>()),
        ),
        ChangeNotifierProxyProvider<LocalStorageService, AuthProvider>(
          create: (context) =>
              AuthProvider(context.read<LocalStorageService>()),
          update: (_, storage, authProvider) {
            authProvider?.initializeAuth();
            return authProvider!;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'متجري',

        /// 🎨 تطبيق الثيم
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,

        /// دعم RTL
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },

        home: _buildHome(),

        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/home': (context) => const HomeScreen(),
          '/cart': (context) => const CartScreen(),
        },

        /// دعم اللغة العربية
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'SA'),
          Locale('en', 'US'),
        ],
      ),
    );
  }

  Widget _buildHome() {
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}