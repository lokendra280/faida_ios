import 'package:faidanepal/controller/auth_controller.dart';
import 'package:faidanepal/controller/banner_controller.dart';
import 'package:faidanepal/controller/campaign_controller.dart';
import 'package:faidanepal/controller/category_controller.dart';
import 'package:faidanepal/controller/location_controller.dart';
import 'package:faidanepal/controller/notification_controller.dart';
import 'package:faidanepal/controller/item_controller.dart';
import 'package:faidanepal/controller/parcel_controller.dart';
import 'package:faidanepal/controller/store_controller.dart';
import 'package:faidanepal/controller/splash_controller.dart';
import 'package:faidanepal/controller/user_controller.dart';
import 'package:faidanepal/helper/responsive_helper.dart';
import 'package:faidanepal/helper/route_helper.dart';
import 'package:faidanepal/util/dimensions.dart';
import 'package:faidanepal/util/images.dart';
import 'package:faidanepal/util/styles.dart';
import 'package:faidanepal/view/base/item_view.dart';
import 'package:faidanepal/view/base/menu_drawer.dart';
import 'package:faidanepal/view/base/paginated_list_view.dart';
import 'package:faidanepal/view/base/web_menu_bar.dart';
import 'package:faidanepal/view/screens/address/address_screen.dart';
import 'package:faidanepal/view/screens/home/theme1/theme1_home_screen.dart';
import 'package:faidanepal/view/screens/home/web_home_screen.dart';
import 'package:faidanepal/view/screens/home/widget/app_bar_home.dart';
import 'package:faidanepal/view/screens/home/widget/drawer.dart';
import 'package:faidanepal/view/screens/home/widget/filter_view.dart';
import 'package:faidanepal/view/screens/home/widget/popular_item_view.dart';
import 'package:faidanepal/view/screens/home/widget/item_campaign_view.dart';
import 'package:faidanepal/view/screens/home/widget/popular_store_view.dart';
import 'package:faidanepal/view/screens/home/widget/banner_view.dart';
import 'package:faidanepal/view/screens/home/widget/category_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faidanepal/view/screens/home/widget/module_view.dart';
import 'package:faidanepal/view/screens/parcel/parcel_category_screen.dart';
import 'package:faidanepal/view/screens/profile/profile_screen.dart';
import 'package:faidanepal/view/screens/wallet/wallet_screen.dart';
import 'package:flutter_svg/svg.dart';

import '../../../util/ui_assets.dart';

class HomeScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {
    if (Get.find<SplashController>().module != null &&
        !Get.find<SplashController>()
            .configModel
            .moduleConfig
            .module
            .isParcel) {
      Get.find<BannerController>().getBannerList(reload);
      Get.find<CategoryController>().getCategoryList(reload);
      Get.find<StoreController>().getPopularStoreList(reload, 'all', false);
      Get.find<CampaignController>().getItemCampaignList(reload);
      Get.find<ItemController>().getPopularItemList(reload, 'all', false);
      Get.find<StoreController>().getLatestStoreList(reload, 'all', false);
      Get.find<ItemController>().getReviewedItemList(reload, 'all', false);
      Get.find<StoreController>().getStoreList(1, reload);
    }
    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<UserController>().getUserInfo();
      Get.find<NotificationController>().getNotificationList(reload);
    }
    Get.find<SplashController>().getModules();
    if (Get.find<SplashController>().module == null &&
        Get.find<SplashController>().configModel.module == null) {
      Get.find<BannerController>().getFeaturedBanner();
      Get.find<StoreController>().getFeaturedStoreList();
      if (Get.find<AuthController>().isLoggedIn()) {
        Get.find<LocationController>().getAddressList();
      }
    }
    if (Get.find<SplashController>().module != null &&
        Get.find<SplashController>().configModel.moduleConfig.module.isParcel) {
      Get.find<ParcelController>().getParcelCategoryList();
    }
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

  @override
  void initState() {
    super.initState();

    HomeScreen.loadData(false);
        if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController?.dispose();
  }

  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      bool _showMobileModule = !ResponsiveHelper.isDesktop(context) &&
          splashController.module == null &&
          splashController.configModel.module == null;
      bool _isParcel = splashController.module != null &&
          splashController.configModel.moduleConfig.module.isParcel;

      return Scaffold(
        
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){
            splashController.removeModule();
          },     icon: SvgPicture.asset(UIAssets.getSvg('drawer.svg')),),
      
          title: Text(" FaidaNepal",style: Theme.of(context).textTheme.bodyText2.copyWith(
            color: Color.fromRGBO(102, 102, 102, 1),fontSize: 18,fontWeight: FontWeight.w700,),),
        
         
          actions: [
            IconButton(
                icon: SvgPicture.asset(UIAssets.getSvg('Notification.svg'),),
                onPressed: () {
                  Get.toNamed(RouteHelper.getNotificationRoute());
                }),
          ],
        ),
      //  endDrawer: MenuDrawer(),
        backgroundColor: ResponsiveHelper.isDesktop(context)
            ? Theme.of(context).cardColor
            : splashController.module == null
                ? Theme.of(context).backgroundColor
                : null,
        body: _isParcel
            ? ParcelCategoryScreen()
            : SafeArea(
              child: RefreshIndicator(
              
                onRefresh: () async {
                  if (Get.find<SplashController>().module != null) {
                    await Get.find<BannerController>().getBannerList(true);
                    await Get.find<CategoryController>()
                        .getCategoryList(true);
                    await Get.find<StoreController>()
                        .getPopularStoreList(true, 'all', false);
                    await Get.find<CampaignController>()
                        .getItemCampaignList(true);
                    await Get.find<ItemController>()
                        .getPopularItemList(true, 'all', false);
                    await Get.find<StoreController>()
                        .getLatestStoreList(true, 'all', false);
                    await Get.find<ItemController>()
                        .getReviewedItemList(true, 'all', false);
                    await Get.find<StoreController>().getStoreList(1, true);
                    if (Get.find<AuthController>().isLoggedIn()) {
                      await Get.find<UserController>().getUserInfo();
                      await Get.find<NotificationController>()
                          .getNotificationList(true);
                    }
                  } else {
                    await Get.find<BannerController>().getFeaturedBanner();
                    await Get.find<SplashController>().getModules();
                    if (Get.find<AuthController>().isLoggedIn()) {
                      await Get.find<LocationController>().getAddressList();
                    }
                    await Get.find<StoreController>().getFeaturedStoreList();
                  }
                },
                child: ResponsiveHelper.isDesktop(context)
                    ? WebHomeScreen(
                        scrollController: _scrollController,
                      )
                    : (Get.find<SplashController>().module != null &&
                            Get.find<SplashController>().module.themeId == 2)
                        ? Theme1HomeScreen(
                            scrollController: _scrollController,
                            splashController: splashController,
                            showMobileModule: _showMobileModule,
                          )
                        : Expanded(
                          child: CustomScrollView(
                            controller: _scrollController,
                                physics: AlwaysScrollableScrollPhysics(),
                              slivers: [
                                        Expanded(
                                          child: SliverToBoxAdapter(
                                          child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH,
                                          child: !_showMobileModule
                                                                  ? Column(crossAxisAlignment:CrossAxisAlignment.start,
                                                                          children: [
                                                                          BannerView(isFeatured: false),
                                                                          CategoryView(),
                                                                          PopularStoreView(isPopular: true,isFeatured: false),
                                                                          ItemCampaignView(),
                                                                          PopularItemView(
                                                                          isPopular: true),
                                                                          PopularStoreView(
                                                                          isPopular: false,
                                                                          isFeatured: false),
                                                                          PopularItemView(
                                                                          isPopular: false),
                                                                          Padding(
                                                                          padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
                                                                          child: Row(
                                                                            children: [
                                                                            Expanded(
                                                          child: Text(
                                                        Get.find<SplashController>()
                                                                .configModel
                                                                .moduleConfig
                                                                .module
                                                                .showRestaurantText
                                                            ? 'all_restaurants'.tr
                                                            : 'all_stores'.tr,
                                                        style: SyneMedium.copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeLarge),
                                                      )),
                                                      FilterView(),
                                                    ]),
                                                  ),
                                                  GetBuilder<StoreController>(
                                                      builder: (storeController) {
                                                    return PaginatedListView(
                                                      scrollController:
                                                          _scrollController,
                                                      totalSize: storeController
                                                                  .storeModel !=
                                                              null
                                                          ? storeController
                                                              .storeModel
                                                              .totalSize
                                                          : null,
                                                      offset: storeController
                                                                  .storeModel !=
                                                              null
                                                          ? storeController
                                                              .storeModel.offset
                                                          : null,
                                                      onPaginate: (int
                                                              offset) async =>
                                                          await storeController
                                                              .getStoreList(
                                                                  offset, false),
                                                      itemView: ItemsView(
                                                        isStore: true,
                                                        items: null,
                                                        stores: storeController
                                                                    .storeModel !=
                                                                null
                                                            ? storeController
                                                                .storeModel.stores
                                                            : null,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                          horizontal: ResponsiveHelper
                                                                  .isDesktop(
                                                                      context)
                                                              ? Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL
                                                              : Dimensions
                                                                  .PADDING_SIZE_SMALL,
                                                          vertical: ResponsiveHelper
                                                                  .isDesktop(
                                                                      context)
                                                              ? Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL
                                                              : 0,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ])
                                          : ModuleView(
                                              splashController: splashController),
                                                                        )),
                                                                      ),
                                        ),
                              ],
                            ),
                        ),
              ),
            ),
      );
    });
  }
}
class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}

