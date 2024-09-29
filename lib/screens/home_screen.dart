import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passwords"),
        actions: [
          IconButton(
            onPressed: () {
              homeController.showAddEditPasswordDialog("insert");
            },
            icon: Icon(
              Icons.add,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (homeController.showContent.value == false) {
            return const Center(child: CircularProgressIndicator());
          }
          if (homeController.passwords.isEmpty) {
            return const Center(
              child: Text(
                "You didn't store any password\nPlease add passowrds",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: homeController.passwords.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 5,
                        offset: const Offset(0, 0),
                        color: Colors.grey.shade200,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        homeController.passwords[index].company,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              homeController.showAddEditPasswordDialog(
                                "edit",
                                homeController.passwords[index].id,
                                homeController.passwords[index].company,
                                homeController.passwords[index].password,
                              );
                            },
                            icon: const Icon(
                              Icons.edit_sharp,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              homeController.showDeleteDialog(
                                homeController.passwords[index].company,
                                homeController.passwords[index].id,
                              );
                            },
                            icon: const Icon(
                              Icons.delete_sharp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
