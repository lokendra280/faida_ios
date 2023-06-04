import 'dart:async';
import 'dart:collection';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:faidanepal/controller/auth_controller.dart';
import 'package:faidanepal/controller/order_controller.dart';
import 'package:faidanepal/controller/splash_controller.dart';
import 'package:faidanepal/data/model/response/order_model.dart';
import 'package:faidanepal/helper/responsive_helper.dart';
import 'package:faidanepal/util/dimensions.dart';
import 'package:faidanepal/util/ui_assets.dart';
import 'package:faidanepal/view/base/cart_widget.dart';
import 'package:faidanepal/view/screens/cart/cart_screen.dart';
import 'package:faidanepal/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:faidanepal/view/screens/dashboard/widget/dashboard_controler.dart';
import 'package:faidanepal/view/screens/favourite/favourite_screen.dart';
import 'package:faidanepal/view/screens/home/home_screen.dart';
import 'package:faidanepal/view/screens/menu/menu_screen.dart';
import 'package:faidanepal/view/screens/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../profile/account_screen.dart';
import 'widget/running_order_view_widget.dart';

class NavigationConstants {
  static const int nestedHomeNavigationId = 1;
  static const int nestedProjectNavigationId = 2;
  static const int subTabLaptopNavigatorId = 3;
}
class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;
  ListQueue<int> _navigationQueue = ListQueue();

  int index = 0;
  final DashboardController dashboardController =
      Get.put(DashboardController());
  GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();

  final List<Widget> dashboardWidgets =  [
      HomeScreen(),
      FavouriteScreen(),
      CartScreen(fromNav: true),
      AccountSection(),
  ];
  bool _isLogin;

  @override
  void initState() {
    super.initState();

    _isLogin = Get.find<AuthController>().isLoggedIn();

    if (_isLogin) {
      Get.find<OrderController>().getRunningOrders(1, fromDashBoard: true);
    }

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      FavouriteScreen(),
      CartScreen(fromNav: true),
     // OrderScreen(),
    
      AccountSection(),
    
    ];

    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });

    /*if(GetPlatform.isMobile) {
      NetworkInfo.checkConnectivity(_scaffoldKey.currentContext);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (!ResponsiveHelper.isDesktop(context) &&
              Get.find<SplashController>().module != null &&
              Get.find<SplashController>().configModel.module == null) {
            Get.find<SplashController>().setModule(null);
            return false;
          } else {
            if (_canExit) {
              return true;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('back_press_again_to_exit'.tr,
                    style: TextStyle(color: Colors.white)),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
                margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              ));
              _canExit = true;
              Timer(Duration(seconds: 2), () {
                _canExit = false;
              });
              return false;
            }
          }
        }
      },
      child: GetBuilder<OrderController>(builder: (orderController) {
        List<OrderModel> _runningOrder =
            orderController.runningOrderModel != null
                ? orderController.runningOrderModel.orders
                : [];

        List<OrderModel> _reversOrder = List.from(_runningOrder.reversed);

        return Scaffold(
          body: Obx(() => IndexedStack(
        index: dashboardController.index.value,
            children: [
            HomeScreen(),
            FavouriteScreen(),
            CartScreen(fromNav: true),
      //OrderScreen(),
          AccountSection(),
            ],
          )),
          bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
              currentIndex: dashboardController.index.value,
              onTap: dashboardController.onBtnNavTap,
            backgroundColor: const Color.fromRGBO(23, 23, 23, 1),
              fixedColor: Colors.white,
      unselectedItemColor: Colors.white,
            // showUnselectedLabels: Color.fromRGBO(rzzzzz, g, b, opacity),
            //   showSelectedLabels: true,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      UIAssets.getSvg("home.svg"),
                      
                    color: Colors.white,
                  ),
                  
                label: "Home".tr,
                
              ),
               BottomNavigationBarItem(
                     icon: SvgPicture.asset(
                      UIAssets.getSvg("fav.svg"),
                                          color: Colors.white,

                    // color: dashboardController.index.value == 1
                    //     ? _selectedColor
                    //     : _unselectedColor,
                  ),
                  label: "Wish List".tr,
              ),
               BottomNavigationBarItem(
                       icon: SvgPicture.asset(
                      UIAssets.getSvg("cart.svg"),
                                          color: Colors.white,

                    // color: dashboardController.index.value == 2
                    //     ? _selectedColor
                    //     : _unselectedColor,
                  ),
                  label: "Cart".tr,
              ),
               BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                      UIAssets.getSvg("person.svg"),
                    // color: dashboardController.index.value == 3
                    //     ? _selectedColor
                    //     : _unselectedColor,
                                        color: Colors.white,

                  ),
                  
                  label: "Account".tr,
              ),

            ])),
        );
      }),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  Widget trackView(BuildContext context, {@required bool status}) {
    return Container(
        height: 3,
        decoration: BoxDecoration(
            color: status
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT)));
  }
}
