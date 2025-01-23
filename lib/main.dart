import 'package:e_commerce/cart/ui/screen/cart_screen.dart';
import 'package:e_commerce/splash_screen.dart';
import 'package:e_commerce/theme/my_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import 'auth/bloc/auth_bloc.dart';
import 'auth/ui/screen/forgot_password_screen.dart';
import 'auth/ui/screen/login_screen.dart';
import 'auth/ui/screen/signup_screen.dart';
import 'base_screen/ui/screen/base_screen.dart';
import 'favorite/ui/screen/favorite_screen.dart';
import 'firebase_options.dart';
import 'favorite/bloc/favorite_bloc.dart';
import 'home/bloc/product_bloc.dart';
import 'home/bloc/product_event.dart';
import 'home/data/models/product_model.dart';
import 'home/data/repositories/product_repository.dart';
import 'home/ui/screen/home_screen.dart';
import 'home/ui/screen/product_detail_screen.dart';
import 'profile/ui/screen/profile_screen.dart';
import 'cart/bloc/cart_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final productRepository = ProductRepository();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => AuthBloc(FirebaseAuth.instance),
      ),
      BlocProvider(create: (context) => ProductBloc(productRepository)..add(FetchProducts())),
      BlocProvider(create: (context) => FavoriteBloc()),
      BlocProvider(create: (context) => CartBloc()),
    ], child: const MyApp()),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const platform = MethodChannel('com.your company.deviceInfo');

  // Updated to pass context to the method
  Future<void> getDeviceInfo(BuildContext context) async {
    try {
      final Map<String, String>? deviceInfo = await platform.invokeMapMethod<String, String>('getDeviceInfo');
      if (deviceInfo != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Device Information"),
            content: Text(deviceInfo.toString()),
          ),
        );
      } else {
        print("No device information received.");
      }
    } on PlatformException catch (e) {
      print("Failed to get device info: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryColor),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        // Initial and Auth Routes
        '/': (context) => const SplashScreen(),
        'login': (context) => const LoginScreen(),
        'signUp': (context) => const SignupScreen(),
        'forgotPassword': (context) => const ForgotPasswordScreen(),

        // Main Routes
        'baseScreen': (context) => const BaseScreen(),
        'home': (context) => const HomeScreen(),
        'favorites': (context) => const FavoriteScreen(),
        'profile': (context) => const ProfileScreen(),
        'cart' : (context) => const CartScreen(),

        // Product Routes
        'productDetail': (context) {
          final product = ModalRoute.of(context)!.settings.arguments as Product;
          return ProductDetailScreen(product: product);
        },
      },
      onGenerateRoute: (settings) {
        // Handle dynamic routes or routes with parameters
        if (settings.name == 'productDetail') {
          final product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          );
        }
        return null;
      },
      onUnknownRoute: (settings) {
        // Handle unknown routes - fallback
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
      },
    );
  }
}
