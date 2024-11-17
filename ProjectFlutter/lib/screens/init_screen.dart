import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/favorite/favorite_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/models/User.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);
  static User? currentUser;
  static String routeName = "/init";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments;
      if (arguments != null && arguments is User) {
        setState(() {
          InitScreen.currentUser = arguments;
        });
      }

      if (InitScreen.currentUser == null) {
        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      }
    });
  }

  void updateCurrentIndex(int index) {
    if (index == 2) {
      Navigator.pushNamed(
        context,
        ProfileScreen.routeName,
        arguments: InitScreen.currentUser,
      );
    } else {
      setState(() {
        currentSelectedIndex = index;
      });
    }
  }

  final List<Widget> pages = [
    const HomeScreen(),
    const FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              color:
                  currentSelectedIndex == 0 ? kPrimaryColor : inActiveIconColor,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Heart Icon.svg",
              color:
                  currentSelectedIndex == 1 ? kPrimaryColor : inActiveIconColor,
            ),
            label: "Fav",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              color:
                  currentSelectedIndex == 2 ? kPrimaryColor : inActiveIconColor,
            ),
            label: "User",
          ),
        ],
      ),
    );
  }
}
