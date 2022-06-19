import 'package:flutter/material.dart';
import 'package:password_save/crud_operation.dart';
import 'package:password_save/snack_bar.dart';

class SetCompanyPassword extends StatefulWidget {
  const SetCompanyPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<SetCompanyPassword> createState() => _SetCompanyPasswordState();
}

class _SetCompanyPasswordState extends State<SetCompanyPassword> {
  TextEditingController companyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DataBaseManager helper = DataBaseManager();
  bool showPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: companyController,
              decoration: InputDecoration(
                hintText: "Company",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                hintText: "Password",
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (companyController.text.isEmpty) {
                  CustomSnackBar.showSnackBar(
                      context, "Company field is empty");
                } else if (passwordController.text.isEmpty) {
                  CustomSnackBar.showSnackBar(
                      context, "Password field is empty");
                } else {
                  helper.addPassword(companyController.text.trim(),
                      passwordController.text.trim());

                      Navigator.pop(context,"Refresh");
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
