// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx_ecommerce/common/widgets/animation/animationwidget.dart';
// import 'package:getx_ecommerce/utils/constants/colors.dart';
// import 'package:getx_ecommerce/utils/helpers/helper_functions.dart';

// class TFullScreenLoader {
//   /// Open a full-screen loading dialog with a given text and animation.
//   /// This method doesn't return anything.
//   ///
//   /// Parameters:
//   ///   text: The text to be displayed in the loading dialog.
//   ///   animation: The Lottie animation to be shown.
//   static void openLoadingDialog(String text, String animation) {
//     showDialog(
//       context: Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
//       barrierDismissible: false, // The dialog can't be dismissed by tapping outside it
//       builder: (context) => PopScope(
//         canPop: false, // Disable popping with the back button
//         child: Container(
//           color: THelperFunctions.isDarkMode(Get.context!)
//               ? CustomColour.dark
//               : CustomColour.white,
//           width: double.infinity,
//           height: double.infinity,
//           child: Column(
//             children: [
//               // Add spacing as needed (replace the placeholder)
//               const SizedBox(height: 250), 

//               // Call your TAnimationLoaderWidget here
//               TAnimationLoaderWidget(text: text, animation: animation),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   //stop the currently open loading dialog
//   //this method doesnt return anything
//   static stopLoading(){
//     Navigator.of(Get.overlayContext!).pop();
//   }
// }
