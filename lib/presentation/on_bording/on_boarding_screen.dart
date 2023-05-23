import 'package:flutter/material.dart';
import 'package:parkin/resources/assets_maneger.dart';
import 'package:parkin/resources/responsive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../resources/color_maneger.dart';
import '../../resources/routes_maneger.dart';
import '../../shared/component/component.dart';
import '../../shared/network/cache_helper.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  final boardingController = PageController();

  void submit() {
    CacheHelper.saveData(key: "OnBoarding", value: true).then((value) {
      if (value) {
        navigateToAndReplacement(
          context,
          Routes.afterLaunch,
        );
      }
    });
  }

  List<BoardingModel> boarding = [
    BoardingModel(
        image: ImageAssets.splashLogo,
        title: "ParkIn",
        body:
            "A smart Parking System application is developed to make parkinging experience easier "),
    BoardingModel(
        image: ImageAssets.vector,
        title: "",
        body:
            "Now you can reserve a parking space for your car remotely without worrying about congestion "),
    BoardingModel(
        image: ImageAssets.splashLogo,
        title: "",
        body: "We wish you a unique user experience"),
    BoardingModel(
        image: ImageAssets.splashLogo, title: "", body: "Provide Spots Nearby"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ImageAssets.onBoarding,
                    ),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    controller: boardingController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (ctx, index) =>
                        buildBoardingItem(boarding[index]),
                    itemCount: boarding.length,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                        controller: boardingController,
                        count: boarding.length,
                        effect: const ExpandingDotsEffect(
                            activeDotColor: ColorManager.white,
                            dotColor: Colors.grey,
                            dotHeight: 10,
                            expansionFactor: 4,
                            dotWidth: 10,
                            spacing: 5)),
                    const Spacer(),
                    isLast
                        ? InkWell(
                            onTap: () {
                              submit();
                            },
                            child: Container(
                              height: 40,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Center(child: Text('Get Started')),
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              boardingController.nextPage(
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Next",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: ColorManager.white),
                                ),
                                responsive.sizedBoxW10,
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: ColorManager.white,
                                  size: 15,
                                )
                              ],
                            )),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(
              model.image,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              model.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            model.body,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: ColorManager.white),
          ),
        ],
      );
}
