import 'package:faidanepal/helper/route_helper.dart';
import 'package:faidanepal/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size(1, 40),
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, RouteHelper.getInitialRoute());
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '${'continue_as'.tr} ',
            style:
                SyneRegular.copyWith(color: Theme.of(context).disabledColor)),
        TextSpan(
            text: 'guest'.tr,
            style: SyneMedium.copyWith(
                color: Theme.of(context).textTheme.bodyText1.color)),
      ])),
    );
  }
}

class SigninButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size(1, 40),
      ),
     onPressed: () => Get.toNamed(
                                  RouteHelper.getSignInRoute(
                                      RouteHelper.signUp)),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '${'sign in'.tr} ',
            style:
                SyneRegular.copyWith(color: Theme.of(context).disabledColor)),
        // TextSpan(
        //     text: 'guest'.tr,
        //     style: SyneMedium.copyWith(
        //         color: Theme.of(context).textTheme.bodyText1.color)),
      ])),
    );
  }
}