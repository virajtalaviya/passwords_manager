// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:password_manager/components/pin_button.dart';

// class PinButtonsWidget extends StatelessWidget {
//   const PinButtonsWidget({
//     super.key,
//     required this.errorWidget,
//   });

//   final Widget errorWidget;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Obx(
//           () {
//             if (errorMessage.value.isEmpty) {
//               return const SizedBox();
//             }
//             return Text(
//               errorMessage.value,
//               style: const TextStyle(
//                 color: Colors.red,
//                 fontSize: 16,
//               ),
//             );
//           },
//         ),
//         Container(
//           height: 50,
//           margin: const EdgeInsets.all(10),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.teal, width: 1),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Obx(() {
//             return Text(
//               pin.value,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//               ),
//             );
//           }),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Button(
//               onPressed: () {
//                 pinButtonPress("1");
//               },
//               name: "1",
//             ),
//             const SizedBox(width: 10),
//             Button(
//               onPressed: () {
//                 pinButtonPress("2");
//               },
//               name: "2",
//             ),
//             const SizedBox(width: 10),
//             Button(
//               onPressed: () {
//                 pinButtonPress("3");
//               },
//               name: "3",
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Button(
//               onPressed: () {
//                 pinButtonPress("4");
//               },
//               name: "4",
//             ),
//             const SizedBox(width: 10),
//             Button(
//               onPressed: () {
//                 pinButtonPress("5");
//               },
//               name: "5",
//             ),
//             const SizedBox(width: 10),
//             Button(
//               onPressed: () {
//                 pinButtonPress("6");
//               },
//               name: "6",
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Button(
//               onPressed: () {
//                 pinButtonPress("7");
//               },
//               name: "7",
//             ),
//             const SizedBox(width: 10),
//             Button(
//               onPressed: () {
//                 pinButtonPress("8");
//               },
//               name: "8",
//             ),
//             const SizedBox(width: 10),
//             Button(
//               onPressed: () {
//                 pinButtonPress("9");
//               },
//               name: "9",
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 50,
//               width: 50,
//             ),
//             const SizedBox(height: 5, width: 5),
//             const SizedBox(width: 10),
//             Button(
//               onPressed: () {
//                 pinButtonPress("0");
//               },
//               name: "0",
//             ),
//             const SizedBox(width: 10),
//             SizedBox(
//               height: 50,
//               width: 50,
//               child: Center(
//                 child: IconButton(
//                   onPressed: eraseValue,
//                   icon: const Icon(
//                     Icons.backspace_sharp,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextButton(
//               onPressed: () {
//                 setpinDoneButton(buttonName);
//               },
//               child: Text(
//                 buttonName,
//                 style: const TextStyle(
//                   color: Colors.purple,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
