import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/components/common_snackbar.dart';
import 'package:password_manager/utils/database_helper.dart';
import 'package:password_manager/utils/preference_utils.dart';
import 'package:password_manager/widgets/delete_dialog.dart';
import 'package:password_manager/widgets/enter_pass_dialog.dart';
import 'package:password_manager/widgets/pin_buttons_widget.dart';

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
        child: DeleteDialog(
          title: title,
          onTapOfDelete: () {
            databaseHelper.deleteData(id);
            Get.back();
            getDataFromDatabase();
          },
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
        child: EnterPassDialog(
          companyController: companyController,
          passwordController: passwordController,
          buttonTapEvent: () {
            if (task == "insert") {
              insertEditdata();
            } else {
              if (id != null) {
                editdata(id);
              }
            }
          },
        ),
      ),
    );
  }

  void showPinDialog(String buttonName) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: PinDialog(
          pin: pin,
          errorMessage: errorMessage,
          buttonName: buttonName,
          onPinComplete: (p0) {
            setpinDoneButton(buttonName);
          },
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
