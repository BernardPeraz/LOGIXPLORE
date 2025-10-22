import 'package:get/state_manager.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/colors.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/models/model_on_boarding.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/on_boarding/on_boarding_page_widget.dart';

class OnBoardingController extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: tOnBoardingImage1,
        title: "Title1",
        subtitle: "subtitle1",
        counterText: "1/3",
        bgcolor: tOnBoardingPage1Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: tOnBoardingImage2,
        title: "Title2",
        subtitle: "subtitle2",
        counterText: "2/3",
        bgcolor: tOnBoardingPage2Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: tOnBoardingImage3,
        title: "Title3",
        subtitle: "subtitle3",
        counterText: "3/3",
        bgcolor: tOnBoardingPage3Color,
      ),
    ),
  ];

  int onPageChangedCallBack(int activePageIndex) =>
      currentPage.value = activePageIndex;
  dynamic skip() => controller.jumpToPage(page: 2);

  void animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }
}
