import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/food/food_screen.dart';

import 'screens/cart/cart_screen.dart';
import 'screens/details/details_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/init_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/Insertion/insert_category.dart';
import 'screens/Insertion/insert_food.dart';
import 'screens/favorite/favorite_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  foodsScreen.routeName: (context) => const foodsScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  InsertCategoryPage.routeName: (context) => InsertCategoryPage(),
  InsertFoodPage.routeName: (context) => InsertFoodPage(),
  FavoriteScreen.routeName: (context) => const FavoriteScreen(),
};
