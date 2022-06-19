import 'package:flutter/material.dart';
import 'package:password_save/crud_operation.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({
    Key? key,
    required this.company,
    required this.password,
  }) : super(key: key);

  final String company;
  final String password;

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController companyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DataBaseManager helper = DataBaseManager();
  bool showPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyController.text = widget.company;
    passwordController.text = widget.password;
    helper.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("You can't change company name"),
              const SizedBox(height: 10),
              TextField(
                readOnly: true,
                controller: companyController,
                style: const TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "Company",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: !showPassword,
                controller: passwordController,
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
              ElevatedButton(
                onPressed: () {
                  helper.updatePassword(
                      companyController.text, passwordController.text);
                  Navigator.pop(context,"Refresh");
                },
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
