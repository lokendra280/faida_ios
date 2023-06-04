import 'package:faidanepal/helper/responsive_helper.dart';
import 'package:faidanepal/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faidanepal/util/styles.dart';

void showCustomSnackBar(String message, {bool isError = true}) {
  if (message != null && message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.only(
        right: ResponsiveHelper.isDesktop(Get.context)
            ? Get.context.width * 0.7
            : Dimensions.PADDING_SIZE_SMALL,
        top: Dimensions.PADDING_SIZE_SMALL,
        bottom: Dimensions.PADDING_SIZE_SMALL,
        left: Dimensions.PADDING_SIZE_SMALL,
      ),
      duration: Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      content: Text(message, style: SyneMedium.copyWith(color: Colors.white)),
    ));
  }
}
