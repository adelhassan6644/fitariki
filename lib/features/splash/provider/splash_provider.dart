import 'package:flutter/cupertino.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';

import '../repo/splash_repo.dart';

class SplashProvider extends ChangeNotifier{
  final SplashRepo splashRepo;
  SplashProvider({required this.splashRepo});

  startTheApp(){
    Future.delayed(const Duration(milliseconds: 4500), () {
      // if (splashRepo.notFirstTime()) {
      //   CustomNavigator.push(Routes.DASHBOARD,replace: true);
      // }else{
      //   CustomNavigator.push(Routes.ON_BOARDING,replace: true);
      // }
      CustomNavigator.push(Routes.ON_BOARDING,replace: true);
      splashRepo.setFirstTime();
    });
  }


}