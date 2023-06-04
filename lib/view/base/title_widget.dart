import 'package:faidanepal/helper/responsive_helper.dart';
import 'package:faidanepal/util/dimensions.dart';
import 'package:faidanepal/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  TitleWidget({@required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title,
          style: SyneMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
      (onTap != null && !ResponsiveHelper.isDesktop(context))
          ? InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  'view_all'.tr,
                  style: SyneMedium.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Colors.black),
                ),
              ),
            )
          : SizedBox(),
    ]);
  }
}
