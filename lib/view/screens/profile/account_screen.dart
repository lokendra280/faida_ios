// import 'package:faidanepal/data/model/response/config_model.dart';
// import 'package:faidanepal/view/screens/auth/widget/forms/buttons.dart';
// import 'package:faidanepal/view/screens/language/widget/language_widget.dart';
// import 'package:faidanepal/view/screens/profile/widget/profile_bg_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controller/auth_controller.dart';
// import '../../../controller/cart_controller.dart';
// import '../../../controller/splash_controller.dart';
// import '../../../controller/user_controller.dart';
// import '../../../controller/wishlist_controller.dart';
// import '../../../helper/route_helper.dart';
// import '../../../util/ui_assets.dart';
// import '../../base/custom_image.dart';

// import '../dashboard/widget/size_constants.dart';

// class AccountSection extends StatefulWidget {

//   @override
//   State<AccountSection> createState() => _AccountSectionState();
// }

// class _AccountSectionState extends State<AccountSection> {
//   bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
  
//    bool _isLogout;


//   @override
//   void initState() {
//     super.initState();

//     if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
//       Get.find<UserController>().getUserInfo();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(body: GetBuilder<UserController>(builder: (userController) {
//       return (_isLoggedIn && userController.userInfoModel == null)
//           ? Center(child: CircularProgressIndicator())
//           : ProfileBgWidget(
//               backButton: true,
//               circularImage: Container(
//                 decoration: BoxDecoration(
//                   border:
//                       Border.all(width: 2, color: Theme.of(context).cardColor),
//                   shape: BoxShape.circle,
//                 ),
//                 alignment: Alignment.center,
//                 child: ClipOval(
//                   child: CustomImage(
//                     image:
//                         '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}'
//                         '/${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.image : ''}',
//                     height: 100,
//                     width: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               mainWidget: SingleChildScrollView(
//                 child: Container(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: SC.lW, vertical: SC.sH),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SBC.xLW,
//                       SBC.xLH,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(214, 40, 40, 0.2),
//                               border: Border.all(
//                                 width: 1,
//                                 color: Colors.white,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 5, right: 7),
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(top: 3),
//                                       // child: Image.asset(
//                                       //   UIAssets.getDummyImage('k1.png'),
//                                       // ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SBC.mH,
//                       InkWell(
//                         onTap: () {
//                           Get.toNamed(RouteHelper.getAddressRoute());
//                         },
//                         child: _settingFeatures(
//                           title: "My Address",
//                           image: "loc.png",
//                         ),
//                       ),
//                       SBC.sH,
//                       // _settingFeatures(
//                       //   title: "Language",
//                       //   image: "lg.png",
//                       // ),
//                       SBC.sH,
//                       InkWell(
//                         onTap: () {
//                           Get.toNamed(RouteHelper.getCouponRoute());
//                         },
//                         child: _settingFeatures(
//                           title: "Coupon",
//                           image: "c.png",
//                         ),
//                       ),
//                       SBC.sH,
//                       _settingFeatures(
//                         title: "Help and Support",
//                         image: "help.png",
//                       ),
//                       SBC.sH,
//                       InkWell(
//                         onTap: () {
//                           Get.toNamed(
//                               RouteHelper.getHtmlRoute('privacy-policy'));
//                         },
//                         child: _settingFeatures(
//                           title: "Privacy Policy",
//                           image: "p.png",
//                         ),
//                       ),
//                       SBC.sH,
//                       InkWell(
//                         onTap: () {
//                           Get.toNamed(RouteHelper.getHtmlRoute('about-us'));
//                         },
//                         child: _settingFeatures(
//                           title: "About Us",
//                           image: "about_us.png",
//                         ),
//                       ),
//                       SBC.sH,
//                       InkWell(
//                         onTap: () {
//                           Get.toNamed(
//                               RouteHelper.getHtmlRoute('terms-and-condition'));
//                         },
//                         child: _settingFeatures(
//                           title: "Terms and Conditions",
//                           image: "term.png",
//                         ),
//                       ),
//                       SBC.sH,
//                       InkWell(
//                         onTap: () {
//                           Get.toNamed(RouteHelper.getConversationRoute());
//                         },
//                         child: _settingFeatures(
//                           title: "Live Chat",
//                           image: "chat.png",
//                         ),
//                       ),
//                       SBC.sH,
//                       _settingFeatures(
//                         title: "Refer & Earn",
//                         image: "ref.png",
//                       ),
//                       SBC.sH,
//                       InkWell(
//                         onTap: () {
//                           Get.toNamed(RouteHelper.getWalletRoute(true));
//                         },
//                         child: _settingFeatures(
//                           title: "Wallet",
//                           image: "wall.png",
//                         ),
//                       ),
//                       SBC.sH,
//                       InkWell(
//                         onTap: () {
//                           Get.toNamed(RouteHelper.getWalletRoute(true));
//                         },
//                         child: _settingFeatures(
//                           title: "Loyalty Points",
//                           image: "loy.png",
//                         ),
//                       ),
//                       SBC.sH,
//                       InkWell(
//                         onTap: () {
//                           Get.toNamed(
//                               RouteHelper.getDeliverymanRegistrationRoute());
//                         },
//                         child: _settingFeatures(
//                           title: "Join as a Delivery Man",
//                           image: "de.png",
//                         ),
//                       ),
//                       SBC.sH,
//                       _settingFeatures(
//                         title: "Join as Store",
//                         image: "store.png",
//                       ),
//                       SBC.lH,
                      
//                       PrimaryButton(
//                         onPressed: () {
//                        Get.find<AuthController>().clearSharedData();
//                       Get.find<CartController>().clearCartList();
//                       Get.find<WishListController>().removeWishes();
//                       Get.offAllNamed(
//                           RouteHelper.getSignInRoute(RouteHelper.splash));
//                         }, 
//                         radius: 10,
//                         title: _isLoggedIn ? 'logout'.tr : 'sign_in'.tr,
//                       ),
                   
//                     ],
//                   ),
//                 ),
//               ),
//             );
//     }));
//   }
// }





import 'package:faidanepal/view/screens/dashboard/widget/size_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../controller/wishlist_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../util/ui_assets.dart';

class AccountSection extends StatefulWidget {
  
  const AccountSection({Key key}) : super(key: key);

  @override
  State<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
      @override
  void initState() {
    super.initState();

    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings",style: Theme.of(context).textTheme.bodyMedium.copyWith(color: Colors.black,
      fontWeight: FontWeight.w700,fontSize: 20,
      ),),
      actions: [
        IconButton(onPressed: (){
   Get.find<AuthController>().clearSharedData();
        Get.find<CartController>().clearCartList();
        Get.find<WishListController>().removeWishes();
         Get.offAllNamed(
         RouteHelper.getSignInRoute(RouteHelper.splash));
        }, icon: Icon(Icons.logout_rounded,color: Color.fromRGBO(0,0,0,1),),)
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      // leading: IconButton(onPressed: (){
          
      // }, icon: Icon(Icons.arrow_back_ios,color: Color.fromRGBO(0, 0, 0, 1),),),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: SC.lH,vertical: SC.lW),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1),borderRadius: BorderRadius.circular(13)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                //     SizedBox(
                //       child: CircleAvatar(
                //         radius: 30,
                //         backgroundImage: NetworkImage(   _isLoggedIn
                // ? '${Get.find<UserController>().userInfoModel.image} '
                // : 'guest'.tr,),
                //       ),
                //     ),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Text( _isLoggedIn
                     ? '${Get.find<UserController>().userInfoModel.fName} ${Get.find<UserController>().userInfoModel.lName}'
                  : 'guest'.tr,style: Theme.of(context).textTheme.bodyText2.copyWith(color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 18,fontWeight: FontWeight.w800),
                        ),
                         Text(   _isLoggedIn
                ? '${Get.find<UserController>().userInfoModel.email} '
                : 'guest'.tr,style: Theme.of(context).textTheme.caption.copyWith(color: Color.fromRGBO(136, 136, 136, 1),
                         fontSize: 11,fontWeight: FontWeight.w500,
                         ),),
                      ],
                    )
                  ],
                ),
              ),
              SBC.xxLH,
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.getProfileRoute());
                },
                child: _ProfileSection(
                  title: "Personal Details",
                  image: "person.svg",
                ),
              ),
              // SBC.xLH,
              // _ProfileSection(
              //   title: "FAQs",
              // ),
           
                 SBC.xLH,
              InkWell(
                onTap: () {
                   Get.toNamed(RouteHelper.getAddressRoute());
                },
                child: _ProfileSection(
                  title: "My Address",
                  image: "location.svg",
                ),
              ),
                 SBC.xLH,
              InkWell(
                onTap: () {
                    Get.toNamed(RouteHelper.getCouponRoute());
                },
                child: _ProfileSection(
                  title: "Coupon",
                  image: "coupon.svg",
                ),
              ),
                 SBC.xLH,
              InkWell(
                onTap: () {
                  Get.to(RouteHelper.getSupportRoute());
                },
                child: _ProfileSection(
                  title: "Help and Support",
                  image: "support.svg",
                ),
              ),
                 SBC.xLH,
              InkWell(
                onTap: () {
                 Get.to(RouteHelper.getHtmlRoute('privacy-policy'))  ;
                },
                child: _ProfileSection(
                  title: "Privacy Policy",
                  image: "privacy.svg",
                ),
              ),
                 SBC.xLH,
              InkWell(
                onTap: () {
                   Get.toNamed(RouteHelper.getHtmlRoute('about-us'));
                },
                child: _ProfileSection(
                  title: "About Us",
                  image: "about.svg",
                ),
              ),
                 SBC.xLH,
              InkWell(
                onTap: () {
                 Get.to( RouteHelper.getHtmlRoute('terms-and-condition'));  
                },
                child: _ProfileSection(
                  title: "Terms and Conditions",
                  image: "term.svg",
                ),
              ),
                 SBC.xLH,
              InkWell(
                onTap: () {
                Get.toNamed(RouteHelper.getConversationRoute());
                },
                child: _ProfileSection(
                  title: "Live Chat",
                  image: "chat.svg",
                ),
              ),
                SBC.xLH,
              InkWell(
                onTap: () {
                Get.toNamed(RouteHelper.getReferAndEarnRoute());
                },
                child: _ProfileSection(
                  title: "Refer & Earn",
                  image: "refer.svg",
                ),
              ),
                SBC.xLH,
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.getWalletRoute(true));
                },
                child: _ProfileSection(
                  title: "Wallet",
                  image: "Wallet.svg",
                ),
              ),
                SBC.xLH,
              InkWell(
                onTap: () {
                Get.toNamed(RouteHelper.getWalletRoute(true));
                },
                child: _ProfileSection(
                  title: "Loyalty Points",
                  image: "point.svg",
                ),
              ),
              SBC.xLH,

                 InkWell(
                  onTap: () {
                  Get.toNamed(RouteHelper.getDeliverymanRegistrationRoute());
                  },
                   child: _ProfileSection(
                                 title: "Join as a Delivery Man",
                     image: "delivery.svg",
                               ),
                 ),
                SBC.xLH,
              InkWell(
                onTap: () {
                Get.toNamed(RouteHelper.getRestaurantRegistrationRoute());

                },
                child: _ProfileSection(
                  title: "Join as Store",
                  image: "store.svg",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
   final String title;
  final String image;
 
   _ProfileSection({
    Key key, this.title,this.image,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(11)
      ),
      child: Row(
       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 1),
            borderRadius: BorderRadius.circular(7)
          ),
          child: SvgPicture.asset(
          UIAssets.getSvg(image),
          color: Colors.white,
          width: 15,
       ),
       
        ),
      SizedBox(width: 30,),
      Text(title,style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14,fontWeight: FontWeight.w600),),
      Spacer(),
      SizedBox(
        child:    SvgPicture.asset(
        UIAssets.getSvg('arrow.svg'),
        color: Colors.black,
        width: 10,
      ),
      )
   
        ],
      ),
    );
  }
}
