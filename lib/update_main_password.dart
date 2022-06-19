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
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String? password;
  bool showPassword = false;

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
                controller: passwordController,
                obscureText: !showPassword,
                decoration: InputDecoration(
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
                onPressed: () {
                  prefs.then((value) {
                    value.setString("Password", passwordController.text);
                  }).then((value) {
                    CustomSnackBar.showSnackBar(context, "Main Password updated Successfully");
                  });
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
