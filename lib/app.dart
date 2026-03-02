import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/index.dart';
import 'screens/index.dart';
import 'services/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider<LocalStorageService>(
          create: (_) => LocalStorageService(prefs),
        ),
        Provider<ApiService>(
          create: (_) => ApiService(),
        ),
        // Providers
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) =>
              CartProvider(context.read<LocalStorageService>()), // ⚡ positional argument
        ),
        ChangeNotifierProxyProvider<LocalStorageService, AuthProvider>(
          create: (context) =>
              AuthProvider(context.read<LocalStorageService>()), // ⚡ positional argument
          update: (_, storage, authProvider) {
            authProvider?.initializeAuth();
            return authProvider!;
          },
        ),
      ],
      child: MaterialApp(
        title: 'متجري',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue.shade900,
            elevation: 0,
            centerTitle: true,
          ),
        ),
        home: _buildHome(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
        // دعم اللغة العربية بالكامل
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'SA'),
          Locale('en', 'US'), // fallback
        ],
      ),
    );
  }

  Widget _buildHome() {
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}