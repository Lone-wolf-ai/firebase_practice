import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class Loaders {
  static void hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static void customToast({required String message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0, // Remove shadow effect
        duration:
            const Duration(seconds: 3), // Duration for which the toast appears
        backgroundColor: Colors.transparent, // Make background transparent
        content: Container(
          padding: const EdgeInsets.all(12.0), // Padding around the content
          margin:
              const EdgeInsets.symmetric(horizontal: 30), // Horizontal margin
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), // Rounded corners
            color: THelperFunctions.isDarkMode(Get.context!)
                ? CustomColour.darkerGrey.withOpacity(0.9)
                : CustomColour.white, // Adjust color based on dark mode
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(Get.context!).textTheme.labelLarge, // Text style
            ),
          ),
        ),
      ),
    );
  }

  static void successSnackBar({
    required String title,
    String message = '',
    int duration = 3,
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: CustomColour.primary,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.check, color: CustomColour.white),
    );
  }

  static void warningSnackBar({
    required String title,
    String message = '',
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: CustomColour.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: CustomColour.white),
    );
  }

  static void errorSnackBar({
    required String title,
    String message = '',
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: CustomColour.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: CustomColour.white),
    );
  }
}
