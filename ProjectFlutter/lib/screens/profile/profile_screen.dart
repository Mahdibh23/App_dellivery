import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Food.dart';
import 'package:shop_app/services/AuthService.dart';
import '../../components/profile_menu.dart';
import '../../components/profile_pic.dart';
import '../../controller/ProfileController.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Consumer<ProfileController>(
        builder: (context, controller, _) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop('/init');
                },
              ),
              title: const Text("Profile"),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  const ProfilePic(),
                  const SizedBox(height: 20),
                  if (controller.currentUser != null)
                    ProfileMenu(
                      text: "My Account",
                      icon: "assets/icons/User Icon.svg",
                      user: controller.currentUser!,
                    ),
                  ProfileMenu(
                    text: "Notifications",
                    icon: "assets/icons/Bell.svg",
                    press: () {},
                  ),
                  ProfileMenu(
                    text: "Settings",
                    icon: "assets/icons/Settings.svg",
                    press: () {},
                  ),
                  ProfileMenu(
                    text: "Help Center",
                    icon: "assets/icons/Question mark.svg",
                    press: () {},
                  ),
                  if (controller.currentUser != null &&
                      controller.currentUser!.type == 'admin') ...[
                    ProfileMenu(
                      text: "Insert Category",
                      icon: "",
                      press: () {
                        Navigator.of(context).pushNamed('/insert_category');
                      },
                    ),
                    ProfileMenu(
                      text: "Insert Food",
                      icon: "",
                      press: () {
                        Navigator.of(context).pushNamed('/insert_food');
                      },
                    ),
                    ProfileMenu(
                      text: "Delete Category",
                      icon: "",
                      press: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Select Category to Delete"),
                              content: controller.isLoadingCategories
                                  ? const CircularProgressIndicator()
                                  : DropdownButtonFormField<int>(
                                      decoration: const InputDecoration(
                                          labelText: 'Category'),
                                      value: controller.selectedCategoryId,
                                      items: controller.categories
                                          .map((Category category) {
                                        return DropdownMenuItem<int>(
                                          value: category.id,
                                          child: Text(category.name),
                                        );
                                      }).toList(),
                                      onChanged: (int? newValue) {
                                        controller.selectedCategoryId =
                                            newValue;
                                      },
                                    ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (controller.selectedCategoryId != null) {
                                      await controller.deleteCategory(
                                          controller.selectedCategoryId!);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    ProfileMenu(
                      text: "Delete Food",
                      icon: "",
                      press: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Select Food to Delete"),
                              content: controller.isLoadingFoods
                                  ? const CircularProgressIndicator()
                                  : DropdownButtonFormField<int>(
                                      decoration: const InputDecoration(
                                          labelText: 'Food'),
                                      value: controller.selectedFoodId,
                                      items: controller.foods.map((Food food) {
                                        return DropdownMenuItem<int>(
                                          value: food.id,
                                          child: Text(food.title),
                                        );
                                      }).toList(),
                                      onChanged: (int? newValue) {
                                        controller.selectedFoodId = newValue;
                                      },
                                    ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (controller.selectedFoodId != null) {
                                      await controller.deleteFood(
                                          controller.selectedFoodId!);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                  ProfileMenu(
                    text: "Log Out",
                    icon: "assets/icons/Log out.svg",
                    press: () async {
                      await AuthService.logout();
                      Navigator.of(context).pushReplacementNamed('/sign_in');
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
