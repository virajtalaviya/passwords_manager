import 'package:flutter/material.dart';
import 'package:password_save/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateMainPassword extends StatefulWidget {
  const UpdateMainPassword({Key? key}) : super(key: key);

  @override
  State<UpdateMainPassword> createState() => _UpdateMainPasswordState();
}

class _UpdateMainPasswordState extends State<UpdateMainPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String? oldPassword;
  bool showOldPassword = false;
  bool showPassword = false;

  getPass() async {
    await prefs.then((value) {
      oldPassword = value.getString("Password");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPass();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update main Password",
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPasswordController,
                obscureText: !showOldPassword,
                decoration: InputDecoration(
                  hintText: "Old Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        showOldPassword = !showOldPassword;
                      });
                    },
                    child: showOldPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
              SizedBox(height: 25),
              TextField(
                controller: passwordController,
                obscureText: !showPassword,
                decoration: InputDecoration(
                    hintText: "New Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: showPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (oldPasswordController.text.trim() != oldPassword) {
                    CustomSnackBar.showSnackBar(
                        context, "Old password is wrong");
                  } else {
                    prefs.then((value) {
                      value.setString("Password", passwordController.text.trim());
                    }).then((value) {
                      CustomSnackBar.showSnackBar(
                          context, "Main Password updated Successfully");
                      Navigator.pop(context,"Call Function");
                    });
                  }
                },
                child: const Text(
                  "Update main Password",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
