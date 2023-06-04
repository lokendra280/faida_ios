import 'package:faidanepal/helper/route_helper.dart';
import 'package:faidanepal/util/images.dart';
import 'package:faidanepal/util/styles.dart';
import 'package:faidanepal/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faidanepal/view/base/footer_view.dart';

class NotLoggedInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FooterView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Images.guest,
                  width: MediaQuery.of(context).size.height * 0.25,
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  'sorry'.tr,
                  style: SyneBold.copyWith(
                      fontSize: MediaQuery.of(context).size.height * 0.023,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  'you_are_not_logged_in'.tr,
                  style: SyneRegular.copyWith(
                      fontSize: MediaQuery.of(context).size.height * 0.0175,
                      color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                SizedBox(
                  width: 200,
                  child: CustomButton(
                      buttonText: 'login_to_continue'.tr,
                      height: 40,
                      onPressed: () {
                        Get.toNamed(
                            RouteHelper.getSignInRoute(RouteHelper.main));
                      }),
                ),
              ]),
        ),
      ),
    );
  }
}
