import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/components/pin_button.dart';

class PinDialog extends StatelessWidget {
  const PinDialog({
    super.key,
    required this.pin,
    required this.errorMessage,
    required this.buttonName,
    required this.onPinComplete,
  });

  final RxString pin;
  final RxString errorMessage;
  final String buttonName;
  final Function(String) onPinComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        _buildNumberPad(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                onPinComplete(buttonName);
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
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        _buildNumberRow(['1', '2', '3']),
        const SizedBox(height: 10),
        _buildNumberRow(['4', '5', '6']),
        const SizedBox(height: 10),
        _buildNumberRow(['7', '8', '9']),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50, width: 50),
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
                  icon: const Icon(Icons.backspace_sharp),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: numbers.map((number) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Button(
            onPressed: () {
              pinButtonPress(number);
            },
            name: number,
          ),
        );
      }).toList(),
    );
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
}
