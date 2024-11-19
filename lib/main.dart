import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pet_door_user/controllers/auth_service.dart';
import 'package:pet_door_user/firebase_options.dart';
import 'package:pet_door_user/provider/cart_provider.dart';
import 'package:pet_door_user/provider/user_provider.dart';
import 'package:pet_door_user/views/bottom_nav.dart';
import 'package:pet_door_user/views/cart.dart';
import 'package:pet_door_user/views/checkout.dart';
import 'package:pet_door_user/views/favourites.dart';
import 'package:pet_door_user/views/login.dart';
import 'package:pet_door_user/views/orders.dart';
import 'package:pet_door_user/views/register.dart';
import 'package:pet_door_user/views/termsAndconditions.dart';
import 'package:pet_door_user/views/update_profile.dart';
import 'package:pet_door_user/views/view_animals.dart';
import 'package:pet_door_user/views/view_animals_home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env["STRIPE_PUBLISH_KEY"]!;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: {
            "/": (context) => UserLogged(),
            "/login": (context) => LoginPage(),
            "/home": (context) => BottomNav(),
            "/signup": (context) => RegisterPage(),
            "/update_profile": (context) => UpdateProfile(),
            '/specific_products': (context) => SpecificProducts(),
            "/view_product": (context) => ViewProduct(),
            "/favourites": (context) => Favourites(),
            "/orders": (context) => OrdersPage(),
            "/cart": (context) => CartPage(),
            "/checkout": (context) => CheckoutPage(),
            "/view_order": (context) => ViewOrder(),
            "/terms": (context) => Terms(),
          }),
    );
  }
}

class UserLogged extends StatefulWidget {
  const UserLogged({super.key});

  @override
  State<UserLogged> createState() => _UserLoggedState();
}

class _UserLoggedState extends State<UserLogged> {
  void initState() {
    AuthService().isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
