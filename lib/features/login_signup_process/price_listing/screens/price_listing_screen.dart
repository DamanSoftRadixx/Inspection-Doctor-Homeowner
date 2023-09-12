import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/price_listing/controller/price_listing_controller.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/price_listing/model/network/categories_response_model.dart';

class PriceListingScreen extends GetView<PriceListingController> {
  const PriceListingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: showAppBar(),
      bottomSheet: showOkButton(),
      body: WillPopScope(
        onWillPop: () async => false,
        child: InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            dismissKeyboard();
          },
          child: SafeArea(
            child: Obx(() => Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          showHeadingText(),
                          showChargesList(),
                        ],
                      ).paddingSymmetric(horizontal: 20.w),
                    ),
                    CommonLoader(isLoading: controller.isShowLoader.value)
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget showChargesList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10.h, bottom: 100.h),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.list.length,
      itemBuilder: (BuildContext context, int index) {
        Category data = controller.list[index];
        return chargesCard(data);
      },
    );
  }

  Container chargesCard(Category data) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
      decoration: inspectionChargesDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                AssetWidget(
                    height: 36.h,
                    width: 36.w,
                    color: lightColorPalette.black,
                    asset: Asset(
                      type: AssetType.network,
                      path: data.image ?? "",
                    )).paddingOnly(right: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: data.name ?? "",
                        style: CustomTextTheme.normalTextWithWeight600(
                          color: lightColorPalette.black,
                        ),
                      ).paddingOnly(bottom: 4.h),
                      AppTextWidget(
                        // overflow: TextOverflow.ellipsis,
                        text: AppStrings.inspectionChargesText.tr,
                        style: CustomTextTheme.bottomTabs(
                            color: lightColorPalette.grey, height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppTextWidget(
            text: "\$${data.price.toString() ?? ""}/hr",
            style: CustomTextTheme.normalTextWithWeight600(
              color: lightColorPalette.black,
            ),
          ).paddingOnly(left: 5.w)
        ],
      ),
    );
  }

  showOkButton() {
    return CommonButton(
        commonButtonBottonText: AppStrings.ok.tr,
        onPress: () {
          Get.toNamed(Routes.dashboard);
        }).paddingOnly(bottom: 17.h, left: 20.w, right: 20.w);
  }

  AppBar showAppBar() {
    return commonAppBarWithOnlyLogo(
      centerWidget: AssetWidget(
        asset: Asset(type: AssetType.svg, path: ImageResource.cid_new),
        boxFit: BoxFit.fitWidth,
      ),
    );
  }

  Column showHeadingText() {
    return Column(
      children: [
        Center(
          child: AppTextWidget(
            text: AppStrings.inspectionCharges.tr,
            style: CustomTextTheme.heading1(
              color: lightColorPalette.black,
            ),
          ),
        ).paddingOnly(top: 57.h, bottom: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AppTextWidget(
                textAlign: TextAlign.center,
                text: AppStrings.youCanCheckThePrice.tr,
                style:
                    CustomTextTheme.normalText(color: lightColorPalette.grey),
              ).paddingSymmetric(horizontal: 30.w),
            ),
          ],
        ),
      ],
    );
  }
}
