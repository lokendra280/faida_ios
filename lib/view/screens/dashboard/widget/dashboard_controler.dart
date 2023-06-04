import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/base_controller.dart';


class DashboardController extends BasePageController {
  RxInt index = 0.obs;

  RxBool isArticleLoading = false.obs;

  //Project Count
  int projectCount = 0;

  //List of project from Api

  //LOADING INDICATORS
  RxBool isLiveProjectLoading = true.obs;

  //LOAD I

  List<String> sliderImages = [];

  @override
  void onInit() async {}

  bool isLoggedIn = false;

  // bool checkLoginStatus() {
  //   return appState.isLoggedIn;
  // }

  bool isProjectsLoading = true;
  String projectFailureMessage = "";
  bool hasProjectLoadFailure = false;

  Future<void> loadProjects() async {
    // isLiveProjectLoading.value = true;

    // final projectListResponse = await _projectRepo.getProjectsList();

    isProjectsLoading = false;
  }

  // appState.isLoggedIn
  //     ?
  //   SHOW LOGOUT DIALOG
  //   await Get.defaultDialog(
  //       title: "Logout",
  //       middleText: "Do you want to logout?",
  //       backgroundColor: AppColors.bgColor,
  //       titleStyle: const TextStyle(color: AppColors.primaryTextColor),
  //       middleTextStyle: const TextStyle(color: AppColors.primaryTextColor),
  //       barrierDismissible: false,
  //       onConfirm: () {
  //         isLoggedIn.value = false;
  //         appState.clearData();
  //         onBtnNavTap(4);
  //         Get.back();
  //       },
  //       onCancel: Get.back)
  //   : Get.toNamed(SignInScreen.route);
  // }

  void onBtnNavTap(int value) {
    index.value = value;
  }

  bool isGetArticlesFailure = false;
  String articleFailureMessage = "";
  bool isArticlesLoading = true;

  // void loadArticles() async {
  //   // isArticleLoading.value = true;

  //   final data = await dashboardRepo.getArticles();

  //   data.fold((error) {
  //     isGetArticlesFailure = true;
  //     isArticlesLoading = false;
  //     articleFailureMessage = error.message;
  //   }, (articles) {
  //     isGetArticlesFailure = false;
  //     isArticlesLoading = false;
  //   });
  // }

  bool isSliderLoading = false;
  bool hasSliderError = false;

  loadSliders() async {
    isSliderLoading = true;

    // final data = await dashboardRepo.getSliders();
    // print(data.length);
    // isSliderLoading = false;

    // data.fold((error) {
    //   hasSliderError = true;
    // }, (sliderList) {
    // });
  }
}