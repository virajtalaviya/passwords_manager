import 'package:flutter/material.dart';
import 'package:password_save/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({Key? key}) : super(key: key);

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  TextEditingController passwordController = TextEditingController();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
   bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
            obscureText: !showPassword,
              controller: passwordController,
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
                if (passwordController.text.isNotEmpty) {
                  prefs.then((value) {
                    value.setString("Password", passwordController.text);
                  }).then((value) {
                    CustomSnackBar.showSnackBar(context, "Saved successfully");
                  });
                  Navigator.pop(context, "Call function");
                }
              },
              child: const Text(
                "Set",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
