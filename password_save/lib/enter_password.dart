import 'package:flutter/material.dart';
import 'package:password_save/password_list.dart';
import 'package:password_save/set_password.dart';
import 'package:password_save/snack_bar.dart';
import 'package:password_save/update_main_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController passwordController = TextEditingController();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String? password;
  bool showPassword = false;

  getPassword() async {
    password = await prefs.then((value) {
      return value.getString("Password");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                
                  onPressed: () async {
                    
                    final data = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetPassword(),
                      ),
                    );
                    if (data == "Call function") {
                      getPassword();
                    }
                    passwordController.clear();
                  },
                  child: const Text(
                    "Set Password",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (password == null) {
                      CustomSnackBar.showSnackBar(
                          context, "Set Password First");
                    } else if (password != passwordController.text) {
                      CustomSnackBar.showSnackBar(
                          context, "Password doesn't match");
                    } else if (password == passwordController.text) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PasswordList(),
                        ),
                      );
                      passwordController.clear();
                    }
                     
                  },
                  child: const Text(
                    "OK",
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (password == null) {
                  CustomSnackBar.showSnackBar(context, "Set Password First");
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdateMainPassword(),
                    ),
                  );
                }
              },
              child: const Text(
                "Update main password",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
