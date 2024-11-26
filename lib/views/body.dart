import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/views/favorite.dart';
import 'package:tasks_manager/views/home_view.dart';
import 'package:tasks_manager/widgets/gradient_background.dart';

import '../controllers/landing_page_controller.dart';

class BodyView extends StatelessWidget {
  BodyView({super.key});
  final LandingPageController landingPageController =
      Get.put(LandingPageController(), permanent: false);

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(
      () => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
        child: SizedBox(
height: MediaQuery.of(context).size.height * 0.1,
          child: Container(
decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.elliptical(50, 30),
                    topLeft: Radius.elliptical(50, 30),
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xFF8A2BE2), Color(0xFF1E90FF)],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),            child: BottomNavigationBar(
              
              type: BottomNavigationBarType.shifting,
              showUnselectedLabels: false,
              showSelectedLabels: true,
              onTap: landingPageController.changeTabIndex,
              currentIndex: landingPageController.tabIndex.value,
              backgroundColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Colors.white.withOpacity(0.5),
              selectedItemColor: Colors.white,
              unselectedLabelStyle: unselectedLabelStyle,
              selectedLabelStyle: selectedLabelStyle,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 7),
                    child: Icon(
                      Icons.home,
                      size: 20.0,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                                    backgroundColor: Colors.transparent,

                  icon: Container(
                    margin: EdgeInsets.only(bottom: 7),
                    child: Icon(
                      Icons.search,
                      size: 20.0,
                    ),
                  ),
                  label: 'Explore',
                  
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: Obx(
          () => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              HomeView(),
              FavoriteTasksPage(),
            ],
          ),
        ),
        bottomNavigationBar:
            buildBottomNavigationMenu(context, landingPageController),
      ),
    );
  }
}
