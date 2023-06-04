import 'package:faidanepal/controller/auth_controller.dart';
import 'package:faidanepal/controller/splash_controller.dart';
import 'package:faidanepal/util/dimensions.dart';
import 'package:faidanepal/util/styles.dart';
import 'package:faidanepal/view/base/custom_app_bar.dart';
import 'package:faidanepal/view/base/menu_drawer.dart';
import 'package:faidanepal/view/base/not_logged_in_screen.dart';
import 'package:faidanepal/view/screens/favourite/widget/fav_item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'favourite'.tr,
      backButton: false, 
      ),
      endDrawer: MenuDrawer(),
      body: Get.find<AuthController>().isLoggedIn()
          ? SafeArea(
              child: Column(children: [
              Container(
                width: Dimensions.WEB_MAX_WIDTH,
                color: Theme.of(context).cardColor,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.black,
                  indicatorWeight: 3,
                  labelColor: Colors.black,
                  unselectedLabelColor: Theme.of(context).disabledColor,
                  unselectedLabelStyle: SyneRegular.copyWith(
                      color: Theme.of(context).disabledColor,
                      fontSize: Dimensions.fontSizeSmall),
                  labelStyle: SyneBold.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Colors.white),
                  tabs: [
                    Tab(text: 'item'.tr),
                    Tab(
                        text: Get.find<SplashController>()
                                .configModel
                                .moduleConfig
                                .module
                                .showRestaurantText
                            ? 'restaurants'.tr
                            : 'stores'.tr),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                children: [
                  FavItemView(isStore: false),
                  FavItemView(isStore: true),
                ],
              )),
            ]))
          : NotLoggedInScreen(),
    );
  }
}
