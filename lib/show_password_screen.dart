import 'package:flutter/material.dart';

class ShowPasswordScreen extends StatefulWidget {
  const ShowPasswordScreen({
    Key? key,
    required this.company,
    required this.passController,
  }) : super(key: key);

  final String company;
  final TextEditingController passController;

  @override
  State<ShowPasswordScreen> createState() => _ShowPasswordScreenState();
}

class _ShowPasswordScreenState extends State<ShowPasswordScreen> {

bool showPassword = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company),
      ),
      body: Center(
        child: TextField(
          obscureText: !showPassword,
          controller: widget.passController,
          readOnly: true,
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
      ),
    );
  }
}
