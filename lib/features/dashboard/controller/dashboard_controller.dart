import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';

class DashboardController extends GetxController{
  Rx<BottomNavigationEnum> bottomNavigationEnum=BottomNavigationEnum.Home.obs;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
  }

  getDashboardTitle(){
    if(bottomNavigationEnum.value==BottomNavigationEnum.Home){
      return AppStrings.homeTab.tr;
    }else if(bottomNavigationEnum.value==BottomNavigationEnum.Inspections){
      return AppStrings.inspectionsTab.tr;
    }else if(bottomNavigationEnum.value==BottomNavigationEnum.Notification){
      return AppStrings.notificationTab.tr;
    }else{
      return AppStrings.myProfileTab.tr;
    }
  }

  onTapTabBar({required BottomNavigationEnum check}){
    bottomNavigationEnum.value = check;
    bottomNavigationEnum.refresh();
  }


}