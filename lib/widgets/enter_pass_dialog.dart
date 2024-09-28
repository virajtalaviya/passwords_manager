import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/components/common_text_field.dart';

class EnterPassDialog extends StatelessWidget {
  const EnterPassDialog({
    super.key,
    required this.companyController,
    required this.passwordController,
    required this.buttonTapEvent,
  });

  final TextEditingController companyController;
  final TextEditingController passwordController;
  final VoidCallback buttonTapEvent;

  @override
  Widget build(BuildContext context) {
    RxBool showPassword = false.obs;
    return Padding(
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
            onPressed: buttonTapEvent,
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
    );
  }
}
