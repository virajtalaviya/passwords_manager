import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/components/common_snackbar.dart';
import 'package:password_manager/components/common_text_field.dart';
import 'package:password_manager/components/pin_button.dart';
import 'package:password_manager/utils/database_helper.dart';
import 'package:password_manager/utils/preference_utils.dart';

class HomeController extends GetxController {
  bool isFirstTime = true;
  RxString pin = "".obs;
  RxString errorMessage = "".obs;
  RxBool showContent = false.obs;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<PasswordsClass> passwords = [];
  TextEditingController companyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool showPassword = false.obs;

  void initAdministration() async {
    isFirstTime = Get.arguments;
    await Future.delayed(const Duration(seconds: 1));
    if (isFirstTime) {
      showPinDialog("Set Pin");
    } else {
      showPinDialog("Done");
    }
  }

  void getDataFromDatabase() async {
    showContent.value = false;
    passwords = await databaseHelper.getAllData();
    showContent.value = true;
  }

  void showDeleteDialog(String title, int id) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Delete $title?",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Are you sure you want to delete passowrd of $title?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      databaseHelper.deleteData(id);
                      Get.back();
                      getDataFromDatabase();
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddEditPasswordDialog(String task, [int? id, String? comp, String? pass]) {
    companyController.clear();
    passwordController.clear();

    if (comp != null && pass != null) {
      companyController.text = comp;
      passwordController.text = pass;
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              CommonTextField(
                textEditingController: companyController,
                hintText: "Company",
              ),
              const SizedBox(height: 10),
              Obx(() {
                return CommonTextField(
                  textEditingController: passwordController,
                  obscureText: !showPassword.value,
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      showPassword.value = !showPassword.value;
                    },
                    icon: Obx(
                      () {
                        if (showPassword.value) {
                          return const Icon(Icons.visibility);
                        }
                        return const Icon(Icons.visibility_off);
                      },
                    ),
                  ),
                );
              }),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (task == "insert") {
                    insertEditdata();
                  } else {
                    if (id != null) {
                      editdata(id);
                    }
                  }
                },
                style: ButtonStyle(
                  elevation: WidgetStateProperty.all(0),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all(Colors.teal),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void showPinDialog(String buttonName) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () {
                if (errorMessage.value.isEmpty) {
                  return const SizedBox();
                }
                return Text(
                  errorMessage.value,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                );
              },
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Obx(() {
                return Text(
                  pin.value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  onPressed: () {
                    pinButtonPress("1");
                  },
                  name: "1",
                ),
                const SizedBox(width: 10),
                Button(
                  onPressed: () {
                    pinButtonPress("2");
                  },
                  name: "2",
                ),
                const SizedBox(width: 10),
                Button(
                  onPressed: () {
                    pinButtonPress("3");
                  },
                  name: "3",
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  onPressed: () {
                    pinButtonPress("4");
                  },
                  name: "4",
                ),
                const SizedBox(width: 10),
                Button(
                  onPressed: () {
                    pinButtonPress("5");
                  },
                  name: "5",
                ),
                const SizedBox(width: 10),
                Button(
                  onPressed: () {
                    pinButtonPress("6");
                  },
                  name: "6",
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  onPressed: () {
                    pinButtonPress("7");
                  },
                  name: "7",
                ),
                const SizedBox(width: 10),
                Button(
                  onPressed: () {
                    pinButtonPress("8");
                  },
                  name: "8",
                ),
                const SizedBox(width: 10),
                Button(
                  onPressed: () {
                    pinButtonPress("9");
                  },
                  name: "9",
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                  width: 50,
                ),
                const SizedBox(height: 5, width: 5),
                const SizedBox(width: 10),
                Button(
                  onPressed: () {
                    pinButtonPress("0");
                  },
                  name: "0",
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: IconButton(
                      onPressed: eraseValue,
                      icon: const Icon(
                        Icons.backspace_sharp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setpinDoneButton(buttonName);
                  },
                  child: Text(
                    buttonName,
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void insertEditdata() async {
    if (companyController.text.trim().isEmpty) {
      CommonSnackBar.showsnackBar("Please enter company name");
    } else if (passwordController.text.trim().isEmpty) {
      CommonSnackBar.showsnackBar("Please enter password");
    } else {
      int value = await databaseHelper.insertData(
        companyController.text.trim(),
        passwordController.text.trim(),
      );
      Get.back();

      if (value != 0) {
        CommonSnackBar.showsnackBar("Password stored successfully");
        getDataFromDatabase();
        companyController.clear();
        passwordController.clear();
      } else {
        CommonSnackBar.showsnackBar("Something went wrong");
      }
    }
  }

  void editdata(int id) async {
    if (companyController.text.trim().isEmpty) {
      CommonSnackBar.showsnackBar("Please enter company name");
    } else if (passwordController.text.trim().isEmpty) {
      CommonSnackBar.showsnackBar("Please enter password");
    } else {
      int value = await databaseHelper.editData(
        companyController.text.trim(),
        passwordController.text.trim(),
        id,
      );
      Get.back();

      if (value != 0) {
        CommonSnackBar.showsnackBar("Password edited successfully");
        getDataFromDatabase();
        companyController.clear();
        passwordController.clear();
      } else {
        CommonSnackBar.showsnackBar("Something went wrong");
      }
    }
  }

  void setpinDoneButton(String buttonName) {
    if (pin.value.isNotEmpty) {
      if (buttonName == "Set Pin") {
        PreferenceUtils.setString("pin", pin.value);
        PreferenceUtils.setBool("isFirstTime", false);
        showContent.value = true;
        Get.back();
      } else {
        if (PreferenceUtils.getString("pin") == pin.value.trim()) {
          getDataFromDatabase();
          Get.back();
        } else {
          errorMessage.value = "Incorrect pin";
        }
      }
    } else {
      errorMessage.value = "Please enter pin";
    }
  }

  void pinButtonPress(String value) {
    pin.value = "${pin.value}$value";
  }

  void eraseValue() {
    errorMessage.value = "";
    if (pin.value.isNotEmpty) {
      pin.value = pin.value.substring(0, pin.value.length - 1);
    }
  }

  @override
  void onInit() {
    super.onInit();
    initAdministration();
  }
}
