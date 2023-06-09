import 'dart:async';
import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:faidanepal/controller/auth_controller.dart';
import 'package:faidanepal/controller/cart_controller.dart';
import 'package:faidanepal/controller/localization_controller.dart';
import 'package:faidanepal/controller/location_controller.dart';
import 'package:faidanepal/controller/splash_controller.dart';
import 'package:faidanepal/controller/theme_controller.dart';
import 'package:faidanepal/controller/wishlist_controller.dart';
import 'package:faidanepal/data/model/body/notification_body.dart';
import 'package:faidanepal/helper/notification_helper.dart';
import 'package:faidanepal/helper/responsive_helper.dart';
import 'package:faidanepal/helper/route_helper.dart';
import 'package:faidanepal/theme/dark_theme.dart';
import 'package:faidanepal/theme/light_theme.dart';
import 'package:faidanepal/util/app_constants.dart';
import 'package:faidanepal/util/messages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/get_di.dart' as di;
import 'package:khalti_flutter/khalti_flutter.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  if (ResponsiveHelper.isMobilePhone()) {
    HttpOverrides.global = new MyHttpOverrides();
  }
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: 'AIzaSyDFN-73p8zKVZbA0i5DtO215XzAb-xuGSE',
      appId: '1:1000163153346:web:4f702a4b5adbd5c906b25b',
      messagingSenderId: 'G-L1GNL2YV61',
      projectId: 'ammart-8885e',
    ));
  }
  await Firebase.initializeApp();
  Map<String, Map<String, String>> _languages = await di.init();

  NotificationBody _body;
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        _body = NotificationHelper.convertNotification(remoteMessage.data);
      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (e) {}

  // if (ResponsiveHelper.isWeb()) {
  //   FacebookAuth.i.webInitialize(
  //     appId: "452131619626499",
  //     cookie: true,
  //     xfbml: true,
  //     version: "v9.0",
  //   );
  // }
  runApp(MyApp(languages: _languages, body: _body));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final NotificationBody body;
  MyApp({@required this.languages, @required this.body});

  void _route() {
    Get.find<SplashController>().getConfigData().then((bool isSuccess) async {
      if (isSuccess) {
        if (Get.find<AuthController>().isLoggedIn()) {
          Get.find<AuthController>().updateToken();
          await Get.find<WishListController>().getWishList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isWeb) {
      Get.find<SplashController>().initSharedData();
      if (Get.find<LocationController>().getUserAddress() != null &&
          Get.find<LocationController>().getUserAddress().zoneIds == null) {
        Get.find<AuthController>().clearSharedAddress();
      }
      Get.find<CartController>().getCartData();
      _route();
    }
    // if(GetPlatform.isAndroid){
    //   Get.find<SplashController>().initSharedData();
    //   if(Get.find<LocationController>().getUserAddress() != null && Get.find<LocationController>().getUserAddress().zoneIds == null) {
    //     Get.find<AuthController>().clearSharedAddress();
    //   }
    //   Get.find<CartController>().getCartData();
    //   _route();
    //
    // }

    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<SplashController>(builder: (splashController) {
          return (GetPlatform.isWeb && splashController.configModel == null)
              ? SizedBox()
              : KhaltiScope(
                  // publicKey:splashController.configModel.khalti.publicKey,
                  publicKey: 'live_public_key_1d87bd66700b48f89d46360efefc8f9d',
                  builder: (context, navigatorKey) {
                    return GetMaterialApp(
                      title: AppConstants.APP_NAME,
                      debugShowCheckedModeBanner: false,
                      navigatorKey: navigatorKey,
                      scrollBehavior: MaterialScrollBehavior().copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch
                        },
                      ),
                      supportedLocales: const [
                        Locale('en', 'US'),
                        Locale('ne', 'NP'),
                      ],
                      localizationsDelegates: const [
                        KhaltiLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                      theme: themeController.darkTheme
                          ? themeController.darkColor == null
                              ? dark()
                              : dark(color: themeController.darkColor)
                          : themeController.lightColor == null
                              ? light()
                              : light(color: themeController.lightColor),
                      locale: localizeController.locale,
                      translations: Messages(languages: languages),
                      fallbackLocale: Locale(
                          AppConstants.languages[0].languageCode,
                          AppConstants.languages[0].countryCode),
                      initialRoute: GetPlatform.isWeb
                          ? RouteHelper.getInitialRoute()
                          : RouteHelper.getSplashRoute(body),
                      getPages: RouteHelper.routes,
                      defaultTransition: Transition.topLevel,
                      transitionDuration: Duration(milliseconds: 500),
                    );
                  });
        });
      });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
